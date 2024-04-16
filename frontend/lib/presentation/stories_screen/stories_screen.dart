import 'package:carousel_slider/carousel_slider.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_circleimage.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_subtitle.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_subtitle_three.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import 'package:vaibhav_s_application2/widgets/custom_text_form_field.dart';
import 'controller/story_controller.dart';

// ignore_for_file: must_be_immutable
class StoryScreen extends GetWidget<StoryController> {
  StoryScreen({Key? key})
      : super(
          key: key,
        );
  StoryController controller = Get.find<StoryController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Obx(
            ()=> CarouselSlider(
              options: CarouselOptions(
                height: double.infinity,
                autoPlay: true,
                enableInfiniteScroll: false,
                aspectRatio: 1,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 1,
              ),
              items: controller.storyModelObj.value.storyItemModel?.attachments?.map(
                      (item) {
                       return CustomImageView(
                          fit: BoxFit.cover,
                          imagePath: item,
                        );
                      }).toList()
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: _buildCommentBox(context),
        ),
      ),
    );
  }

  Widget _buildCommentBox(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h, right: 16.h, bottom: 12.v),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: CustomTextFormField(
              hintText: "Add your comment here...".tr,
              controller: controller.commentController,
              textInputAction: TextInputAction.done,
              textStyle: CustomTextStyles.titleLargeBlack900,
              hintStyle: CustomTextStyles.titleMediumGray600,
              borderDecoration: TextFormFieldStyleHelper.fillSecondaryContainer,
              fillColor: theme.colorScheme.secondaryContainer,
              autofocus: false,
            ),
          ),
          // _buildTextField(),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomIconButton(
                height: 50.adaptSize,
                width: 50.adaptSize,
                padding: EdgeInsets.all(13.h),
                decoration: IconButtonStyleHelper.fillDeepPurpleATL25,
                onTap: () {
                  // onTapAddComment(postModel);
                },
                child: CustomImageView(imagePath: ImageConstant.imgGroup9143)),
          )
        ]));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 80.v,
      leadingWidth: 66.h,
      leading: Obx(
        ()=> AppbarLeadingCircleimage(
          imagePath: controller.storyModelObj.value.storyItemModel?.avatar,
          margin: EdgeInsets.fromLTRB(16.h, 24.v, 0, 0),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          left: 15.h,
          top: 24.v,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
            ()=> AppbarSubtitle(
                text: controller.storyModelObj.value.storyItemModel?.fullname ?? "null",
              ),
            ),
            SizedBox(height: 5.v),
            Obx(
              ()=> AppbarSubtitleThree(
                text: controller.storyModelObj.value.storyItemModel?.createdAt ?? "null",
                margin: EdgeInsets.only(right: 76.h),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgClose,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.v),
          onTap: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
