import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaibhav_s_application2/presentation/profile_page/models/user_posts_list.dart';
import 'package:vaibhav_s_application2/presentation/profile_page/models/user_profile_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';
import 'package:vaibhav_s_application2/repositories/posts_repository.dart';
import '../../../core/app_export.dart';
import '../../home_screen/controller/home_screen_controller.dart';

/// A controller class for the ProfilePage.
///
/// This class manages the state of the ProfilePage, including the
/// current profileModelObj
class SearchedProfileController extends GetxController {
  SearchedProfileController(this.userPostListItemObj, this.userProfileModelObj);

  Rx<UserPostsList> userPostListItemObj;
  Rx<UserProfileModel> userProfileModelObj;
  RxBool isClear = false.obs;
  RxString userId = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      userId.value = Get.arguments;
    }
    print(userId);
    getUserPostsList();
    getUserProfile();
  }

  PostsRepository postsRepository = PostsRepository();

  AuthRepository authRepository = AuthRepository();

  Future<void> getUserPostsList() async {

    await postsRepository.getUserPostsList(userId.value).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      userPostListItemObj.value = UserPostsList.fromJson(data);
      userProfileModelObj.refresh();
    });
  }

  Future<void> getUserProfile() async{

    await authRepository.getUserProfile(userId.value).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      userProfileModelObj.value = UserProfileModel.fromJson(data);
      userProfileModelObj.refresh();
    });
  }
}
