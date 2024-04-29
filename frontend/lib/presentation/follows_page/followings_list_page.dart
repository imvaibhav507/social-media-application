import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/controller/follows_controller.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/followers_list_model/followers_list_model.dart';
import 'package:vaibhav_s_application2/presentation/follows_page/followers_list_model/followings_list_model.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';

import '../notifications_page/controller/notifications_controller.dart';

class FollowingsPage extends StatelessWidget {
  FollowingsPage({Key? key}) : super(key: key);

  var controller = Get.put(FollowsController(FollowingsListModel().obs, FollowersListModel().obs));
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
                : _buildFollowingsList(),
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
            onTapArrowBack();
        },
      ),
      title: Padding(
          padding: EdgeInsets.only(left: 16.h),
          child:
          Text("Followings".tr, style: theme.textTheme.headlineLarge)),
    );
  }

  Widget _buildFollowingsList() {
    if (controller.followingsListModelObj.value.followingsListModel != null &&
        controller.followingsListModelObj.value.followingsListModel!.isEmpty) {
      return Center(
          child: Text(
            'You have no followings currently',
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
              .followingsListModelObj.value.followingsListModel?.length ??
              0,
          itemBuilder: (context, index) {
            final followingListItem = controller
                .followingsListModelObj.value.followingsListModel?[index];
            return _buildFollowingsItemModel(followingListItem);
          }),
    );
  }

  onTapArrowBack() {
    Get.back();
  }

  Widget _buildFollowingsItemModel(FollowingModel? followingModel) {
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
              imagePath: followingModel?.avatar ?? '',
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
                      followingModel?.name ?? '',
                      style: CustomTextStyles.titleMediumBlack90001,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  SizedBox(
                    width: 90.h,
                    child: Text(
                      '@${followingModel?.username}' ?? '',
                      style: CustomTextStyles.bodyLargeGray600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 108.h,
            ),
            CustomIconButton(
              width: 90.h,
              height: 40.v,
              child: Center(
                child: Text(
                  'Unfollow',
                  style: CustomTextStyles.bodyLargePrimary,
                ),
              ),
              onTap: () {
                onTapRemoveFollowing(followingModel?.userId);
              },
            ),
            SizedBox(
              width: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  void onTapRemoveFollowing(String? userId) async{
    await controller.unFollowUser(userId!);
  }

}
