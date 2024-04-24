
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:vaibhav_s_application2/main.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chatroom_details_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/personal_chat_details_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/send_message_model.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/controller/messages_controller.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/models/messageslist_item_model.dart';
import 'package:vaibhav_s_application2/repositories/chatroom_repository.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';
import '../../../core/app_export.dart';
import '../models/chat_model.dart';

/// A controller class for the ChatScreen.
///
/// This class manages the state of the ChatScreen, including the
/// current chatModelObj
class ChatController extends GetxController {
  ChatController(
      this.chatScreenModelObj, this.chatroomDetailsObj, this.chatModelListObj, this.personalChatDetailsObj);
  Rx<ChatScreenModel> chatScreenModelObj;
  RxList<ChatModel> chatModelListObj;
  Rx<ChatroomDetailsModel> chatroomDetailsObj;
  Rx<PersonalChatDetailsModel> personalChatDetailsObj;
  final ChatroomRepository chatroomRepository = ChatroomRepository();
  TextEditingController textMessageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  HomeScreenController homeScreenController = Get.find<HomeScreenController>();
  String? chatroomId;
  bool? isGroupChat;
  String? userId;
  int? index;
  RxMap? typingUser = {}.obs;
  late Socket socket;
  int page = 1;
  final int limit = 10;
  bool isLoading = false;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    textMessageController.dispose();
    socket.emit("leave chatroom", chatroomId);
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    chatroomId = Get.arguments['chatroomId'];
    isGroupChat = Get.arguments['isGroupChat'];
    index = Get.arguments['index'] ?? 0;
    print('chatroom: ${chatroomId}');
    print('isGroupChat: ${isGroupChat}');
    await getUserId();
    getChatDetails(chatroomId!);
    getMessagesList(chatroomId!);
    scrollController.addListener(scrollListener);
    socket = homeScreenController.socket;
    joinChatroom();
    addNewMessage();
    emitTyping();
    emitStopTyping();
    onTyping();
    onStopTyping();
  }

  joinChatroom() {
    socket.emit("join chatroom", chatroomId);
  }

  emitTyping() {
    final user = homeScreenController.loggedInUserModelObj.value.data?.fullname;
    final id = homeScreenController.loggedInUserModelObj.value.data?.sId;
    socket.emit("typing", {'chatroom':chatroomId, 'user': user, 'userId': id});
  }

  onTyping() {
    socket.on("typing", (data) {
      typingUser?.value = data;
      print('${typingUser?['user']} is typing');
    });
  }

  onStopTyping() {
    socket.on("stop typing", (_){
      typingUser?.value = {};
      print('typing stopped');
    });
  }
   emitStopTyping() {
    socket.emit("stop typing", chatroomId);
   }
  //
  // updateList() {
  //   final chatModel = chatModelListObj.first;
  //   final item =  messagesController.messagesListModelObj
  //       .value.messagesItems?.where((item) => item.sId == chatroomId).single;
  //   messagesController.messagesListModelObj.value.messagesItems?.remove(item);
  //   messagesController.messagesListModelObj.value
  //       .messagesItems?.insert(0, new MessagesItemModel(
  //       sId: item?.sId,
  //       avatar: item?.avatar,
  //       name: item?.name,
  //       lastMessage: chatModel.content,
  //       time: chatModel.time,
  //       isGroupChat: item?.isGroupChat,
  //       otherMembers: item?.otherMembers
  //   ));
  // }

  addNewMessage() {
    socket.on("new message", (data) {
      final chatModel = new ChatModel.fromJson(data);
      print('message from realtime${data}');
      if(!(chatModel.senderId==userId)) {
        chatScreenModelObj.value.chatItems!.insert(0, chatModel);
      }
      socket.emit("update chat", {'chatroom': chatroomId, 'user':userId});
    });
  }

  Future<void> getChatDetails(String id) async {
    if(isGroupChat == true){
      await chatroomRepository.getChatroomDetails(id).then((value) async {
        final response = await ApiResponse.completed(value);
        final data = response.data as Map<String, dynamic>;
        chatroomDetailsObj.value = new ChatroomDetailsModel.fromJson(data);
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    } else {
      await chatroomRepository.getPersonalChatDetails(id).then((value) async {
        final response = await ApiResponse.completed(value);
        final data = response.data as Map<String, dynamic>;
        personalChatDetailsObj.value = new PersonalChatDetailsModel.fromJson(data);
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

  }

  Future<void> getMessagesList(String id) async {
    await chatroomRepository
        .getMessagesList(id, page, limit)
        .then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      chatScreenModelObj.value = new ChatScreenModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> loadMoreMessages() async {
    if (!isLoading) {
      try {
        await chatroomRepository
            .getMessagesList(chatroomId!, page + 1, limit)
            .then((value) async {
          final response = await ApiResponse.completed(value);
          final data = response.data as Map<String, dynamic>;
          chatScreenModelObj.value.chatItems
              ?.addAll(new ChatScreenModel.fromJson(data).chatItems!);
          page++;
        });
      } catch (error) {
        print("Error fetching more messages: $error");
      } finally {
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
    final createdMessage = new ChatModel(
      sId: RxString('sending${uuid.v4()}'),
      content: RxString(data.message!),
      name: RxString(homeScreenController.loggedInUserModelObj.value.data!.fullname!),
      senderId: RxString(userId!),
      attachments: RxList([''].cast<String>()),
      time: RxString('Just now'),
      createdAt: RxString(new DateTime.now().toString())
    );
    print('old id ${createdMessage.sId}');
    chatScreenModelObj.value.chatItems!.insert(0, createdMessage);
    await chatroomRepository.sendMessage(data.toJson()).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      final receivedMessage = new ChatModel.fromJson(data['data']);
      final index = chatScreenModelObj.value
          .chatItems?.indexWhere((model) => model.sId == createdMessage.sId);
      if(!(index==-1 || index == null)) {
        chatScreenModelObj.value.chatItems?[index] = receivedMessage;
        print('new id ${chatScreenModelObj.value.chatItems?[index].sId}');
      }

    });
  }

  Future<void> deleteGroup() async {
    await chatroomRepository.deleteChatroom(chatroomId!).then((value) async {
      final response = await ApiResponse.completed(value);
      var messagesController = Get.find<MessagesController>();
      messagesController.messagesListModelObj.value
          .messagesItems!.removeWhere((item) => item.sId == chatroomId);
      Get.back();
    });
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreMessages();
    }
  }
}
