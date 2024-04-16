import 'package:vaibhav_s_application2/presentation/profile_page/models/user_posts_list.dart';
import 'package:vaibhav_s_application2/presentation/profile_page/models/user_profile_model.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/profile_controller.dart';

// ignore_for_file: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  ProfileController controller =
      Get.put(ProfileController(UserPostsList().obs, UserProfileModel().obs), permanent: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            onTapProfileDetails();
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 16.h),
                              child: Row(children: [
                                Obx(
                                  () => CustomImageView(
                                      imagePath: controller.userProfileModelObj
                                          .value.profileDetails?.avatar,
                                      height: 80.adaptSize,
                                      width: 80.adaptSize,
                                      radius: BorderRadius.circular(40.h)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.h, top: 11.v, bottom: 4.v),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () => Text(
                                                controller
                                                        .userProfileModelObj
                                                        .value
                                                        .profileDetails
                                                        ?.fullname ??
                                                    "null",
                                                style: CustomTextStyles
                                                    .headlineLargeBlack90001),
                                          ),
                                          SizedBox(height: 4.v),
                                          Obx(
                                            () => Text(
                                                "@${controller.userProfileModelObj.value.profileDetails?.username}" ??
                                                    "null",
                                                style: CustomTextStyles
                                                    .bodyMediumBluegray400),
                                          )
                                        ]))
                              ])))),
                  SizedBox(height: 16.v),
                  _buildCountsRow(),
                  SizedBox(height: 16.v),
                  _buildMenuRow(),
                  SizedBox(height: 2.v),
                  _buildProfileList()
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(height: 50.v,
        actions: [
      CustomElevatedButton(
        margin: EdgeInsets.only(right: 10.h),
        buttonTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        text: "Logout",
        height: 40.v,
        width: 100.h,
        onPressed: () => onPressedLogout(),
      ),
    ]);
  }

  /// Section Widget
  Widget _buildCountsRow() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(children: [
            Text("lbl_post".tr, style: CustomTextStyles.titleLargeGray500),
            SizedBox(height: 10.v),
            Obx(() => Text(
                controller.userProfileModelObj.value.profileDetails?.postsCount
                        .toString() ??
                    "0",
                style: CustomTextStyles.titleLargeDeeppurpleA200))
          ]),
          Obx(
            () => _buildFollowersColumn(
                followersText: "lbl_following".tr,
                zipcodeText: controller
                        .userProfileModelObj.value.profileDetails?.followings
                        .toString() ??
                    "0"),
          ),
          Obx(
            () => _buildFollowersColumn(
                followersText: "lbl_followers".tr,
                zipcodeText: controller
                        .userProfileModelObj.value.profileDetails?.followers
                        .toString() ??
                    "0"),
          )
        ]));
  }

  /// Section Widget
  Widget _buildMenuRow() {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 16.v),
        decoration: AppDecoration.fillGray,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomImageView(
              imagePath: ImageConstant.imgMenu,
              height: 40.adaptSize,
              width: 40.adaptSize),
          CustomImageView(
              imagePath: ImageConstant.imgImage,
              height: 40.adaptSize,
              width: 40.adaptSize),
          CustomImageView(
              imagePath: ImageConstant.imgPlayCircleOutline,
              height: 40.adaptSize,
              width: 40.adaptSize),
          CustomImageView(
              imagePath: ImageConstant.imgQueueMusic,
              height: 40.adaptSize,
              width: 40.adaptSize)
        ]));
  }

  /// Section Widget
  Widget _buildProfileList() {
    return Obx(
      () => Expanded(
        child: GridView.count(
          mainAxisSpacing: 2.adaptSize,
          crossAxisSpacing: 2.adaptSize,
          crossAxisCount: 3,
          children: List.generate(
              controller.userPostListItemObj.value.userPostsList?.length ?? 0,
              (index) {
            return Stack(children: [
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.adaptSize),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CustomImageView(
                    imagePath: controller.userPostListItemObj.value
                            .userPostsList?[index].cover ??
                        "null",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: CustomImageView(
                  color: appTheme.gray50.withOpacity(0.8),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.h),
                  height: 23.v,
                  imagePath: ImageConstant.imgImages,
                ),
              )
            ]);
          }),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildFollowersColumn({
    required String followersText,
    required String zipcodeText,
  }) {
    return Column(children: [
      Text(followersText,
          style: CustomTextStyles.titleLargeGray500
              .copyWith(color: appTheme.gray500)),
      SizedBox(height: 10.v),
      Text(zipcodeText,
          style: CustomTextStyles.titleLargeDeeppurpleA200
              .copyWith(color: appTheme.deepPurpleA200))
    ]);
  }

  /// Navigates to the detailedProfileScreen when the action is triggered.
  onTapProfileDetails() {
    Get.toNamed(
      AppRoutes.detailedProfileScreen,
    );
  }

  onPressedLogout() async {
    await controller.logoutUser();
  }
}
