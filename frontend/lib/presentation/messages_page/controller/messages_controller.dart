import 'package:vaibhav_s_application2/presentation/messages_page/models/messageslist_item_model.dart';
import 'package:vaibhav_s_application2/repositories/chatroom_repository.dart';

import '../../../core/app_export.dart';
import '../models/messages_model.dart';

/// A controller class for the MessagesPage.
///
/// This class manages the state of the MessagesPage, including the
/// current messagesModelObj
class MessagesController extends GetxController {
  MessagesController(this.messagesListModelObj);

  final ChatroomRepository chatroomRepository = ChatroomRepository();

  Rx<MessageslistModel> messagesListModelObj;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    messagesListModelObj = MessageslistModel().obs;
    getChatroomList();

  }

  Future<void> getChatroomList() async{
    await chatroomRepository.getChatroomList().then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      messagesListModelObj.value = new MessageslistModel.fromJson(data);
    }).onError((error, stackTrace) {print(error.toString());});
  }

  Future<void> getSingleChatroomListItem(String chatroomId) async {
    await chatroomRepository.getSingleChatroomListItem(chatroomId).then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      MessagesItemModel model = MessagesItemModel.fromJson(data['data']);
      messagesListModelObj.value.messagesItems?.update(
              (list) {
                var listItem = list?.where((item) => item.sId==chatroomId).single;
                listItem!.lastMessage!.value = model.lastMessage!.value;
                listItem.time!.value = model.time!.value;
                list?.remove(listItem);
                list?.insert(0, listItem);
              });
    });
  }
}
