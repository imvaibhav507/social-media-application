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
import 'controller/for_you_controller.dart';

// ignore_for_file: must_be_immutable
class ForYouScreen extends GetWidget<ForYouController> {
  const ForYouScreen({Key? key})
      : super(
          key: key,
        );

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
          child: CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              autoPlay: true,
              enableInfiniteScroll: false,
              aspectRatio: 1,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
            items: [
              CustomImageView(
                fit: BoxFit.cover,
                imagePath: ImageConstant.imgForYou,
              ),
              CustomImageView(
                fit: BoxFit.cover,
                imagePath: ImageConstant.imgForYou,
              ),
              CustomImageView(
                fit: BoxFit.cover,
                imagePath: ImageConstant.imgChatBkg,
              ),
            ]
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
      leading: AppbarLeadingCircleimage(
        imagePath: ImageConstant.imgEllipse9,
        margin: EdgeInsets.only(
          left: 16.h,),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          left: 24.h,
          top: 3.v,
        ),
        child: Column(
          children: [
            AppbarSubtitle(
              text: "lbl_lucas_anna".tr,
            ),
            SizedBox(height: 5.v),
            AppbarSubtitleThree(
              text: "lbl_35_16".tr,
              margin: EdgeInsets.only(right: 76.h),
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
