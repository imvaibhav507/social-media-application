import 'package:vaibhav_s_application2/presentation/add_member_screen/models/search_users_model.dart';
import 'package:vaibhav_s_application2/repositories/chatroom_repository.dart';
import '../../../core/app_export.dart';

class AddMemberController extends GetxController {

  AddMemberController(this.searchUsersModelObj);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chatroomId = Get.arguments;
    print(chatroomId);
  }

  String? chatroomId;

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

  Future<void> addMembersToChatroom(var data) async {
    _isAddMemberLoading.value = true;
    await chatroomRepository.addMembersToChatroom(data).then(
            (value) async{
              final response = await ApiResponse.completed(value);
              print(response.data);
              _isAddMemberLoading.value = false;
              Get.back();
            }).onError((error, stackTrace) {
              _isAddMemberLoading.value = false;
            print(error.toString());
    });
  }

}