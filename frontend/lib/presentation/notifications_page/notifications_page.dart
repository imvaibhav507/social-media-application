import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:vaibhav_s_application2/presentation/notifications_page/models/recent_follow_request_model.dart';
import 'package:vaibhav_s_application2/presentation/notifications_page/widgets/recent_follow_request_item_widget.dart';
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
      Get.put(NotificationsController(NotificationsModel().obs, RecentFollowRequestModel().obs));

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



  /// Section Widget
  Widget _buildNotificationsList() {
    return  Obx(
        ()=> ListView.separated(
            shrinkWrap: false,
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
                .notificationsModelObj.value.notificationslistItemList.value.length,
            itemBuilder: (context, index) {
              NotificationslistItemModel model = controller.notificationsModelObj
                  .value.notificationslistItemList.value[index];
              if(index==0) {
                return Obx(
                        ()=> (controller.recentFollowRequestModelObj.value.recentRequestModelObj==null) ? Container():
                RecentFollowRequestItemWidget(controller.recentFollowRequestModelObj.value.recentRequestModelObj!.value));
              }
              index--;
              return NotificationslistItemWidget(model);
            }),
    );
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
