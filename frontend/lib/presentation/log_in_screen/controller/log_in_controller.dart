import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';

import '../../../core/app_export.dart';
import 'package:flutter/material.dart';

/// A controller class for the LogInScreen.
///
/// This class manages the state of the LogInScreen, including the
/// current logInModelObj
class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  AuthRepository _authRepository = AuthRepository();

  RxBool loading = false.obs;

  void setLoading(value) {
    loading.value = value;
  }

  // Rx<LogInModel> logInModelObj = LogInModel().obs;

  Rx<bool> isShowPassword = true.obs;

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> userLogin(var data) async {
    setLoading(true);
    await _authRepository.loginApi(data)
        .then((value) async {
      setLoading(false);
      final response = ApiResponse.completed(value).data as Map<String,dynamic>;
      print(response);
      String accessToken = response['data']['accessToken'].toString();
      String userId = response['data']['userId'].toString();
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString('accessToken', accessToken.trim());
      await sp.setString('userId', userId.trim());
      if(response['statusCode']==200) {
        Get.offAllNamed(AppRoutes.containerScreen);
      }
    });
  }

  // @override
  // void onReady() {
  //   Get.toNamed(
  //     AppRoutes.forgotPasswordScreen,
  //   );
  // }
}
