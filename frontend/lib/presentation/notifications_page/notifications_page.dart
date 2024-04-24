import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/notificationslist_item_widget.dart';
import 'models/notificationslist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/notifications_controller.dart';
import 'models/notifications_model.dart';

// ignore_for_file: must_be_immutable
class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key? key}) : super(key: key);

  NotificationsController controller =
      Get.put(NotificationsController(NotificationsModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: _buildNotificationsList()
        ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 85.v,
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowBackDeepPurpleA200,
            margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapArrowBack();
            }),
        title: Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text("lbl_notifications".tr,
                style: theme.textTheme.headlineLarge)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgPersonAddAlt1,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
              onTap: () {
                onTapPersonAddAltOne();
              })
        ]);
  }

  Widget _buildFollowRequest() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.followRequestsPage);
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.h,
              child: Stack(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.img32,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    radius: BorderRadius.circular(
                      27.h,
                    ),
                    margin: EdgeInsets.only(bottom: 26.v),
                  ),
                  Positioned(
                    left: 8.h,
                      top: 8.v,
                      child: CustomImageView(
                        imagePath: ImageConstant.img22,
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        radius: BorderRadius.circular(
                          27.h,
                        ),
                        margin: EdgeInsets.only(bottom: 26.v),
                      ),
                  )
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.h,
                bottom: 28.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Follow Requests',
                      style: CustomTextStyles.titleMediumBlack90001,
                    ),
                  SizedBox(height: 7.v),
                   Text(
                      '@username',
                      style: CustomTextStyles.bodyLargeGray600,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  /// Section Widget
  Widget _buildNotificationsList() {
    return Obx(() => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.5.v),
              child: SizedBox(
                  width: double.maxFinite,
                  child: Divider(
                      height: 2.v,
                      thickness: 2.v,
                      color: theme.colorScheme.secondaryContainer)));
        },
        itemCount: controller
            .notificationsModelObj.value.notificationslistItemList.value.length+1,
        itemBuilder: (context, index) {
          if(index == 0) {
            return _buildFollowRequest();
          }
          index--;
          NotificationslistItemModel model = controller.notificationsModelObj
              .value.notificationslistItemList.value[index];
          return NotificationslistItemWidget(model);
        }));
  }

  /// Navigates to the previous screen.
  onTapArrowBack() {
    Get.back();
  }

  /// Opens a URL in the device's default web browser.
  ///
  /// The [context] parameter is the `BuildContext` of the widget that invoked the function.
  ///
  /// Throws an exception if the URL could not be launched.
  onTapPersonAddAltOne() async {
    var url = 'https://accounts.google.com/';
    if (!await launchUrlString(url)) {
      throw 'Could not launch https://accounts.google.com/';
    }
  }
}
