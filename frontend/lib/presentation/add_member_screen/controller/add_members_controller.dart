import 'package:vaibhav_s_application2/presentation/add_member_screen/models/search_users_model.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/models/messageslist_item_model.dart';
import 'package:vaibhav_s_application2/repositories/chatroom_repository.dart';
import 'package:vaibhav_s_application2/widgets/custom_snackbar.dart';
import '../../../core/app_export.dart';
import '../../messages_page/controller/messages_controller.dart';

class AddMemberController extends GetxController {

  AddMemberController(this.searchUsersModelObj);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chatroomId = Get.arguments['chatroomId'];
    groupName = Get.arguments['groupName'];
    print(chatroomId);
  }

  String? chatroomId;
  String? groupName;

  ChatroomRepository chatroomRepository = ChatroomRepository();

  Rx<SearchUsersModel> searchUsersModelObj;

  RxList<User> userModels = <User>[].obs;

  get isListLoading => _isListLoading;
  get isAddMemberLoading => _isAddMemberLoading;

  RxBool _isListLoading = false.obs;
  RxBool _isAddMemberLoading = false.obs;

  Future<void> getFoundUsersList(String chatroomId, String key) async{
    _isListLoading.value = true;
    await chatroomRepository.getSearchedUsers(chatroomId, key)
        .then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      searchUsersModelObj.value = new SearchUsersModel.fromJson(data);
      _isListLoading.value = false;
    }).onError((error, stackTrace) {
      _isListLoading.value = false;
      print(error.toString());
    });
  }

  Future<void> addMembersToChatroom(var details) async {
    _isAddMemberLoading.value = true;
    await chatroomRepository.addMembersToChatroom(details).then(
            (value) async{
              final response = await ApiResponse.completed(value);
              final data = response.data as Map<String, dynamic>;
              print(response.data);
              if(data['statusCode'] == 200) {
                _isAddMemberLoading.value = false;
                Get.back();
                CustomSnackBar().showSnackBar(text: 'New people were added to the group');
              }

            }).onError((error, stackTrace) {
              _isAddMemberLoading.value = false;
            print(error.toString());
    });
  }

  Future<void> createNewGroup(var data)  async {
    await chatroomRepository.createGroupChat(data).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      print(response.data);
      MessagesItemModel createdGroup = MessagesItemModel.fromJson(data['data']);
      print(createdGroup);
      if(data['statusCode']==200) {
        var messagesController = Get.find<MessagesController>();
        messagesController.messagesListModelObj.value.messagesItems?.insert(0, createdGroup);
        Get.offNamed(
            AppRoutes.chatroomScreen,
            arguments: {'chatroomId':createdGroup.sId?.value, 'isGroupChat': true,}
        );
      }
    });
  }
}