import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/app_export.dart';
import '../models/splash_model.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('accessToken');
      if(token == null || token.isEmpty) {
        Get.toNamed(
          AppRoutes.loginScreen,
        );
      }
      else Get.offAllNamed(AppRoutes.containerScreen);

    });
  }
}
