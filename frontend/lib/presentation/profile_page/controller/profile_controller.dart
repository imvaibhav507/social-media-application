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
class ProfileController extends GetxController {
  ProfileController(this.userPostListItemObj, this.userProfileModelObj);

  Rx<UserPostsList> userPostListItemObj;
  Rx<UserProfileModel> userProfileModelObj;
  RxBool isClear = false.obs;
  RxString userId = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    getUserPostsList();
    getUserProfile();
  }

  PostsRepository postsRepository = PostsRepository();

  AuthRepository authRepository = AuthRepository();

  Future<void> logoutUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear().then((value) {
      isClear.value = value;
      if(isClear.value) {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
  }

  Future<void> getUserPostsList() async {
    var homeScreenController = Get.find<HomeScreenController>();
    userId.value = homeScreenController.loggedInUserModelObj.value.data!.sId!;
    await postsRepository.getUserPostsList(userId.value).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      userPostListItemObj.value = UserPostsList.fromJson(data);
      userProfileModelObj.refresh();
    });
  }

  Future<void> getUserProfile() async{
    var homeScreenController = Get.find<HomeScreenController>();
    userId.value = homeScreenController.loggedInUserModelObj.value.data!.sId!;
    await authRepository.getUserProfile(userId.value).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      userProfileModelObj.value = UserProfileModel.fromJson(data);
      userProfileModelObj.refresh();
    });
  }
}
