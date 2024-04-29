import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import '../../core/app_export.dart';
import 'controller/add_story_controller.dart';

class AddStoryScreen extends GetWidget<AddStoryController> {
  AddStoryScreen({Key? key})
      : super(
          key: key,
        );
  AddStoryController controller = Get.find<AddStoryController>();
  var homeScreenController = Get.put(HomeScreenController());

  final TransformationController _controller = TransformationController();
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.black900,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          height: 800.v,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: AppDecoration.gradientGrayToBlack.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder22,
          ),
          child: InteractiveViewer(
            transformationController: _controller,
            onInteractionUpdate: (details) {
              _scale = _controller.value.getMaxScaleOnAxis();
            },
            minScale: 1.0,
            maxScale: 4.0,
            child: Image.file(
                File(controller.capturedImages[0].path),
              fit: BoxFit.contain,
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 80.v,
      leadingWidth: 66.h,
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

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 65.v,
      margin: EdgeInsets.only(left: 200.h),
      decoration: BoxDecoration(
        color: appTheme.black900,
      ),
      child: CustomIconButton(
        width: 160.h,
        height: 50.v,
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          color: appTheme.gray50.withOpacity(.2),
          borderRadius: BorderRadius.circular(25.h)
        ),
        onTap: () {
          onTapAddStory();
        },
        child: Row(
          children: [
            CustomImageView(
              margin: EdgeInsets.only(left: 10.h),
              height: 40,
              width: 30,
              imagePath: homeScreenController.loggedInUserModelObj.value.data?.avatar,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(
                80.h,
              ),
              alignment: Alignment.center,
            ),
            SizedBox(width: 8.h,),
            Text('Your Story', style: CustomTextStyles.bodyLargePrimary,)
          ],
        ),
      ),
    );
  }

  Future<void> onTapAddStory() async{
    controller.addStory();
    Get.offAllNamed(AppRoutes.containerScreen);
  }
}
