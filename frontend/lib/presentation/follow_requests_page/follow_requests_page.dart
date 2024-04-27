import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/follow_requests_page/controller/follow_requests_controller.dart';
import 'package:vaibhav_s_application2/presentation/follow_requests_page/models/follow_requests_model.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';

import '../notifications_page/controller/notifications_controller.dart';

class FollowRequestsPage extends StatelessWidget {
  FollowRequestsPage({Key? key}) : super(key: key);

  var controller = Get.put(FollowRequestsController(FollowRequestsModel().obs));
  var notificationsController = Get.find<NotificationsController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: _buildAppBar(),
        body: (controller.isLoading.isTrue)
            ? Center(
                child: CircularProgressIndicator(
                color: appTheme.black90001,
              ))
            : _buildFollowRequestsList(),
      ),
    ));
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 85.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowBackDeepPurpleA200,
          margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
          onTap: () {
            notificationsController.getRecentFollowRequest();
            onTapArrowBack();
          }),
      title: Padding(
          padding: EdgeInsets.only(left: 16.h),
          child:
              Text("Follow Requests".tr, style: theme.textTheme.headlineLarge)),
    );
  }

  Widget _buildFollowRequestsList() {
    if (controller.followRequestsModelObj.value.followRequestsList != null &&
        controller.followRequestsModelObj.value.followRequestsList!.isEmpty) {
      return Center(
          child: Text(
        'No Pending Requests!',
        style: CustomTextStyles.titleLargeBlack900,
      ));
    }
    return Obx(
      () => ListView.separated(
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
                  .followRequestsModelObj.value.followRequestsList?.length ??
              0,
          itemBuilder: (context, index) {
            final requestListItem = controller
                .followRequestsModelObj.value.followRequestsList?[index];
            return _buildFollowRequest(requestListItem);
          }),
    );
  }

  onTapArrowBack() {
    Get.back();
  }

  Widget _buildFollowRequest(FollowRequestItemModel? requestListItem) {
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
            CustomImageView(
              imagePath: requestListItem?.avatar ?? '',
              height: 52.adaptSize,
              width: 52.adaptSize,
              radius: BorderRadius.circular(
                27.h,
              ),
              margin: EdgeInsets.only(bottom: 26.v),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.h,
                bottom: 28.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96.h,
                    child: Text(
                      requestListItem?.name ?? '',
                      style: CustomTextStyles.titleMediumBlack90001,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  SizedBox(
                    width: 90.h,
                    child: Text(
                      '@${requestListItem?.username}' ?? '',
                      style: CustomTextStyles.bodyLargeGray600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.h,
            ),
            CustomIconButton(
              width: 90.h,
              height: 40.v,
              child: Center(
                child: Text(
                  'Approve',
                  style: CustomTextStyles.bodyLargePrimary,
                ),
              ),
              onTap: () {
                onTapApproveRequest(requestListItem?.sId, 'accepted');
              },
            ),
            SizedBox(
              width: 10.h,
            ),
            CustomIconButton(
              width: 96.h,
              height: 40.v,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.adaptSize),
                  color: appTheme.blueGray100,
                  border:
                      Border.all(width: 2.adaptSize, color: appTheme.gray200)),
              child: Center(
                child: Text(
                  'Deny',
                  style: CustomTextStyles.bodyLargePrimary,
                ),
              ),
              onTap: () {
                onTapApproveRequest(requestListItem?.sId, 'rejected');
              },
            ),
          ],
        ),
      ),
    );
  }

  onTapApproveRequest(requestId, response) async {
    await controller.approveFollowRequest(requestId, response);
  }
}
