import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/followers_list_model/followers_list_model.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/followers_list_model/followings_list_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';

class FollowsController extends GetxController {

  FollowsController(this.followingsListModelObj, this.followersListModelObj);

  Rx<FollowingsListModel> followingsListModelObj;

  Rx<FollowersListModel> followersListModelObj;

  RxBool isLoading = false.obs;

  // RxString? navigateTo;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var navigateTo = await Get.arguments;
    print(navigateTo);
    if(navigateTo == 'followings') {
      await getFollowingsList();
    }
    else if(navigateTo == 'followers') {
      await getFollowersList();
    }
  }

  setLoading(value) {
    isLoading.value = value;
  }

  AuthRepository authRepository = AuthRepository();

  Future<void> getFollowingsList() async {
    setLoading(true);
    authRepository.getFollowingsList().then((value) async {
      setLoading(false);
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      followingsListModelObj.value = FollowingsListModel.fromJson(data);
    });
    setLoading(false);
  }

  Future<void> getFollowersList() async {
    setLoading(true);
    authRepository.getFollowersList().then((value) async {
      setLoading(false);
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      followersListModelObj.value = FollowersListModel.fromJson(data);
    });
    setLoading(false);
  }

  Future<void> unFollowUser(String userId) async {
    setLoading(true);
    authRepository.unfollowUser(userId).then((value) async {
      setLoading(false);
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      followingsListModelObj.value
          .followingsListModel?.removeWhere((user) => user.userId == userId);
    });
    setLoading(false);
  }

  Future<void> removeFollowerUser(String userId) async {
    setLoading(true);
    authRepository.removeFollowerUser(userId).then((value) async {
      setLoading(false);
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      followersListModelObj.value
          .followersListModel?.removeWhere((user) => user.userId == userId);
    });
    setLoading(false);
  }

}