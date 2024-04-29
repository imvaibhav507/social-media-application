import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/create_post_page/controller/create_post_controller.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_elevated_button.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';

class CreatePostPage extends GetWidget<CreatePostController> {
  CreatePostPage({Key? key}):super(key: key);

  CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildPreviewWidget(),
            SizedBox(height: 20.v),
            buildAddCaption(),
          ],
        ),
      ),
      bottomNavigationBar: buildShareButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
          imagePath: ImageConstant.imgArrowBackDeepPurpleA200,
          margin: EdgeInsets.only(left: 16.h, top: 13.v, bottom: 13.v),
          onTap: () {
            onTapArrowBack();
          }),
      title: Padding(
        padding: EdgeInsets.all(8.adaptSize),
        child: Text('New Post',
            style: theme.textTheme.headlineLarge
        ),
      ),
      actions: [
        // buildNextButton(),
      ],
    );
  }

  void onTapArrowBack() {
    Get.back();
  }

  Widget buildPreviewWidget() {
    return Obx(
      ()=> Container(
        margin: EdgeInsets.symmetric(vertical: 16.v, horizontal: 8.h),
        width: double.maxFinite,
        height: 450.v,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: appTheme.gray200,
          borderRadius: BorderRadius.circular(16.adaptSize)
        ),
        child: (controller.createPostModelObj
            .value.files!.isEmpty)? Padding(
              padding: EdgeInsets.all(140.adaptSize),
              child: CustomImageView(
                        imagePath: ImageConstant.addImage,
                        color: appTheme.blueGray700,
                onTap: () {controller.openImagePicker();},
                      ),
            )
            : CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            autoPlay: false,
            enableInfiniteScroll: false,
            aspectRatio: 1/1,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 1,
            clipBehavior: Clip.antiAlias
          ),
          items: [...?controller.createPostModelObj
              .value.files?.map(
                  (file)=> Padding(
                    padding: EdgeInsets.all(2.adaptSize),
                    child: Image.file(
                      File(file!.path),
                        isAntiAlias: true,
                      fit: BoxFit.fitWidth,
                    ),
                  )).toList(),
            Padding(
              padding: EdgeInsets.all(140.adaptSize),
              child: CustomImageView(
                imagePath: ImageConstant.addImage,
                color: appTheme.blueGray700,
                onTap: () {controller.openImagePicker();},
              ),
            )
          ]
        ),
      ),
    );
  }

  buildNextButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10.adaptSize),
        child: Text('Next', style: CustomTextStyles.titleLargeDeeppurpleA200),
      ),
      
    );
  }

  Widget buildAddCaption() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.v),
      width: double.maxFinite,
      height: 150.v,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.adaptSize),
        border: Border.all(width: 4.adaptSize, color: appTheme.deepPurpleA200),
      ),
      child: TextField(
        controller: controller.captionsController,
        style: CustomTextStyles.bodyLargeBlack90001,
        maxLines: null,
        expands: true,
        cursorColor: appTheme.deepPurpleA200,
        decoration: InputDecoration(
          hintText: 'Add caption...',
          border: InputBorder.none
        ),
      ),
    );
  }

  buildShareButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 10.v),
      child: Obx(
          ()=> CustomElevatedButton(
            rightIcon: (controller.isLoading.isTrue)?
            Container(
              width: 30.adaptSize,
                height: 30.adaptSize,
                child: CircularProgressIndicator(strokeWidth: 2.adaptSize,)): null,
            text: (controller.isLoading.isTrue)? '': 'Share' ,
          buttonTextStyle: CustomTextStyles.titleLargePrimary,
          onPressed: () {onPressedUploadPost();}
        ),
      ),
    );
  }

  onPressedUploadPost() async {
    await controller.createPost();
    Get.offAllNamed(AppRoutes.containerScreen);
  }
}
