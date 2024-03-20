import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/app_export.dart';
import '../models/profile_model.dart';

/// A controller class for the ProfilePage.
///
/// This class manages the state of the ProfilePage, including the
/// current profileModelObj
class ProfileController extends GetxController {
  ProfileController(this.profileModelObj);

  Rx<ProfileModel> profileModelObj;
  RxBool isClear = false.obs;

  Future<void> logoutUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear().then((value) {
      isClear.value = value;
      if(isClear.value) {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
  }
}
