import 'package:vaibhav_s_application2/presentation/search_screen/models/search_model.dart';
import '../controller/search_controller.dart';
import 'package:vaibhav_s_application2/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class RecentsearchesItemWidget extends StatelessWidget {
  RecentsearchesItemWidget(
    this.foundUserProfileModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  FoundUserProfileModel foundUserProfileModelObj;

  var controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
              imagePath: foundUserProfileModelObj.avatar,
              height: 50.adaptSize,
              width: 50.adaptSize,
              radius: BorderRadius.circular(
                25.h,
              ),
              margin: EdgeInsets.only(bottom: 18.v),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.h,
              top: 2.v,
              bottom: 17.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    foundUserProfileModelObj.fullname ?? 'null',
                    style: theme.textTheme.titleLarge,
                  ),
                SizedBox(height: 5.v),
                Text(
                    '@${foundUserProfileModelObj.username}' ?? 'null',
                    style: CustomTextStyles.bodyMediumGray600,
                  ),
              ],
            ),
          ),
          Spacer(),
          (foundUserProfileModelObj.followedByYou == false) ? _buildFollowButton1() : Container(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFollowButton1() {
    return CustomOutlinedButton(
      width: 76.h,
      text: "lbl_follow".tr,
      margin: EdgeInsets.only(
        top: 9.v,
        bottom: 26.v,
      ),
    );
  }
}


