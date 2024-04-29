import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomSnackBar {
  showSnackBar({required String text}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      backgroundColor: appTheme.gray50,
      width: 350.h,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.adaptSize)),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          text,
          style: CustomTextStyles.bodyLargeBlack90001,
        ),
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
