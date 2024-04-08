import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chatroom_details_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/send_message_model.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/controller/messages_controller.dart';
import 'package:vaibhav_s_application2/repositories/chatroom_repository.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

import '../../../core/app_export.dart';
import '../models/chat_model.dart';

/// A controller class for the ChatScreen.
///
/// This class manages the state of the ChatScreen, including the
/// current chatModelObj
class ChatController extends GetxController {

  ChatController(this.chatScreenModelObj, this.chatroomDetailsObj, this.chatModelListObj);
  late Socket socket;
  Rx<ChatScreenModel> chatScreenModelObj;
  RxList<ChatModel> chatModelListObj;
  Rx<ChatroomDetailsModel> chatroomDetailsObj;
  final ChatroomRepository chatroomRepository = ChatroomRepository();
  TextEditingController textMessageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  MessagesController messagesController = Get.find<MessagesController>();
  String? chatroomId;
  String? userId;

  int page = 1;
  final int limit = 10;
  bool isLoading = false;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    textMessageController.dispose();
  }
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    chatroomId = Get.arguments;
    print(chatroomId);
    await getUserId();
    getChatDetails(chatroomId!);
    getMessagesList(chatroomId!);
    scrollController.addListener(scrollListener);
    connectSocket();
    joinChatroom();
  }

  joinChatroom() {
    socket.emit("join chat", userId);
  }

  addNewMessage(data) {

    final chatModel = ChatModel(
      sId: Rx('0'),
      senderId: Rx(userId!),
      attachments: Rx([]),
      name: Rx('name'),
      time: Rx(DateTime.now().toString()),
      content : Rx(data['message']!),
    );
    chatScreenModelObj.value.chatItems!.insert(0,chatModel);

    socket.emit("message sent", data);
    print(chatModel.content);
  }


  connectSocket() {
    socket = io(AppUrl.hostUrl,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build()
    );
    socket.emit("setup", userId);
    socket.connect();
    socket.onConnect((_){
      print("connected to frontend");
    });

    socket.on("message sent", (data) {
      print(data);
    });
    update();
  }

  Future<void> getChatDetails(String id) async {
    await chatroomRepository.getChatroomDetails(id)
        .then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      chatroomDetailsObj.value = new ChatroomDetailsModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> getMessagesList(String id) async {
    await chatroomRepository.getMessagesList(id, page, limit)
        .then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      chatScreenModelObj.value = new ChatScreenModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> loadMoreMessages() async {
    if(!isLoading) {
      try {
        await chatroomRepository.getMessagesList(chatroomId!, page+1, limit)
            .then((value) async{
          final response = await ApiResponse.completed(value);
          print(response.data);
          final data = response.data as Map<String, dynamic>;
          chatScreenModelObj.value.chatItems?.addAll(new ChatScreenModel.fromJson(data).chatItems!);
          page++;
        });
      }catch(error) {
        print("Error fetching more messages: $error");
      }finally {
        isLoading = false;
        update();
      }
    }
  }

  Future<String?> getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    userId = sp.getString('userId');
    print(userId);
    return userId;
  }

  Future<void> sendMessage(SendMessageModel data) async {
    await chatroomRepository.sendMessage(data.toJson())
    .then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      await messagesController.getSingleChatroomListItem(chatroomId!);
    });
  }

  Future<void> deleteGroup() async {
    await chatroomRepository.deleteChatroom(chatroomId!)
    .then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      messagesController.messagesListModelObj.value.messagesItems!
          .update((list) {
            list?.removeWhere((item) => item.sId == chatroomId);
      });
      Get.back();
    });
  }



  void scrollListener() {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMoreMessages();
    }

  }
}
