import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../data/models/sign_up_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the SignUpScreen.
///
/// This class manages the state of the SignUpScreen, including the
/// current signUpModelObj
class SignUpController extends GetxController {
  TextEditingController firstNameRowController = TextEditingController();

  TextEditingController lastNameRowController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<SignUpModel> signUpModelObj = SignUpModel().obs;

  AuthRepository _authRepository = AuthRepository();

  RxBool loading = false.obs;

  void setLoading(value) {
    loading.value = value;
  }

  @override
  void onClose() {
    super.onClose();
    firstNameRowController.dispose();
    lastNameRowController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    dateOfBirthController.dispose();
  }

  Future<void> userSignup(var data) async {
    setLoading(true);
    await _authRepository
        .signupApi(data)
        .then((value) async{
          setLoading(false);
          final response = ApiResponse.completed(value);
          print(response.data);
          final data = response.data as Map<String, dynamic>;
          if(data['statusCode'] == 200) {
            Fluttertoast.showToast(
                msg: "You are signed in !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.transparent,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Get.offNamed(AppRoutes.addAvatarScreen);
          }
          else Fluttertoast.showToast(
              msg: "Something went wrong !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.transparent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }).onError((error, stackTrace){
          setLoading(false);
    });
  }

  Future<void> userLogin(var data) async {
    setLoading(true);
    await _authRepository.loginApi(data)
        .then((value) async {
          setLoading(false);
          final response = ApiResponse.completed(value);
          print(response.data);
          final data = response.data as Map<String, dynamic>;
          String accessToken = data['data']['accessToken'].toString();
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString('accessToken', accessToken.trim());
    });
  }
}
