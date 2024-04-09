import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/logged_in_user_model.dart';
import 'package:vaibhav_s_application2/presentation/login_screen/models/login_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';
import '../../../core/app_export.dart';
import '../models/home_screen_model.dart';

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  TextEditingController searchController = TextEditingController();

  AuthRepository _authRepository = AuthRepository();

  Rx<HomeScreenModel> homeScreenModelObj =
      HomeScreenModel().obs;

  Rx<LoggedInUserModel> loggedInUserModelObj =
      LoggedInUserModel().obs;

  late TabController tabviewController =
  Get.put(TabController(vsync: this, length: 4));

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLoggedInUser();
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
