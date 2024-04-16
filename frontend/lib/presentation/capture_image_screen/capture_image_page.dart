import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/presentation/capture_image_screen/controller/capture_image_controller.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import '../../core/app_export.dart';
class CaptureImageScreen extends GetWidget<CaptureImageController> {
  CaptureImageScreen({Key? key})
      : super(
          key: key,
        );
  CaptureImageController controller = Get.find<CaptureImageController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.black900,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: GestureDetector(
          onVerticalDragUpdate: (details){
            if (details.delta.dy < -10) {
              // User is swiping up

              controller.fileManagerTwo.openGallery(context: Get.context!, isMultiImage: true);
            }
          },
          child: Stack(
            children:[
              Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: AppDecoration.gradientGrayToBlack.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder22,
                    ),
                    child: Obx(() {
                      if (controller.isCameraInitialized.isTrue) {
                        return controller.cameraController.buildPreview();
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ),
                _buildBottomNavigationBar(),

              ],
            ),
              Positioned(
                bottom: 40.v,
                left: 0,
                right: 0,
                child:  Center(
                  child: CustomImageView(
                    height: 75.h,
                    imagePath: ImageConstant.imgCameraClick,
                    onTap: () async {
                      // Take a picture
                      await controller.takePicture();
                    },
                  ),
                )
              )
            ]
          ),
        ),
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
      height: 80.v,
      decoration: BoxDecoration(
        color: appTheme.black900,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            margin: EdgeInsets.symmetric(vertical: 8.v, horizontal: 6.h),
            height: 40.v,
            width: 40.h,
            imagePath: ImageConstant.imgGallery,
            onTap: () async{
              await controller.selectImagesFromGallery();
            }
          ),
          CustomImageView(
            margin: EdgeInsets.symmetric(vertical: 8.v, horizontal: 6.h),
            height: 40.v,
            width: 40.h,
            imagePath: ImageConstant.imgFlip,
            onTap: () async{
              await controller.switchCamera();
            },
          ),
        ],
      ),
    );
  }

}


