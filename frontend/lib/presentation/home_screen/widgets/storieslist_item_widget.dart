import 'package:flutter/cupertino.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/stories_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/storieslist_item_model.dart';

import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class Profileslist1ItemWidget extends StatelessWidget {
  Profileslist1ItemWidget(
      this.storiesListItemModelObj, {
        Key? key,
      }) : super(
    key: key,
  );

  StoriesListItemModel storiesListItemModelObj;

  var controller = Get.find<StoriesController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.v,
      width: 100.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
                () => CustomImageView(
              imagePath: storiesListItemModelObj.nineteen!.value,
              height: 120.v,
              width: 100.h,
              radius: BorderRadius.circular(
                15.h,
              ),
              alignment: Alignment.center,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.v),
              decoration:
              AppDecoration.gradientOnPrimaryContainerToBlueGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgPlay,
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    margin: EdgeInsets.only(left: 4.h),
                  ),
                  SizedBox(
                    width: 50.h,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 70.v,
                        bottom: 8.v,
                      ),
                      child: Obx(
                            () => Text(
                          storiesListItemModelObj.agnessMonica!.value,
                          style: CustomTextStyles.labelMediumPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
