import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class AppbarLeadingCircleimage extends StatelessWidget {
  AppbarLeadingCircleimage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.circleBorder25,
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          child: CustomImageView(
            imagePath: imagePath,
            height: 45.adaptSize,
            width: 45.adaptSize,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(
              100.adaptSize,
            ),
          ),
        ),
      ),
    );
  }
}
