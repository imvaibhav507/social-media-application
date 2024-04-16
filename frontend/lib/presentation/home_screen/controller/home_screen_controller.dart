import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/controller/daily_new_controller.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/comments_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/like_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/post_model.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/stories_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/logged_in_user_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';
import '../../../core/app_export.dart';
import '../models/home_screen_model.dart';
import '../models/stories_model.dart';

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  TextEditingController searchController = TextEditingController();

  AuthRepository _authRepository = AuthRepository();

  Rx<LoggedInUserModel> loggedInUserModelObj =
      LoggedInUserModel().obs;

  late TabController tabviewController =
  Get.put(TabController(vsync: this, length: 2));

  var storiesController = Get.put(StoriesController(StoriesListModel().obs));
  var postsController = Get.put(DailyNewController(PostsModel().obs, LikeModel().obs, CommentsModel().obs));
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoggedInUser();
    storiesController.getAllStories();
    postsController.getAllPosts();
  }


  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  Future<void> getLoggedInUser() async {
    _authRepository.loggedInUser().then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      loggedInUserModelObj.value = LoggedInUserModel.fromJson(data);
    });
  }
}
