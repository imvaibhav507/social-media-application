import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/stories_model.dart';

// ignore: must_be_immutable
class Profileslist1ItemWidget extends StatelessWidget {
  Profileslist1ItemWidget(
      this.storiesListItemModelObj, {
        Key? key,
      }) : super(
    key: key,
  );

  StoriesListItemModel storiesListItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.v,
      width: 70.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CustomImageView(
            imagePath: storiesListItemModelObj.cover,
            height: 75.v,
            width: 60.h,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(
              15.h,
            ),
            alignment: Alignment.center,
          ),
          Positioned(
            right: 36,
            top: 64,
            child: Container(
              height: 36.adaptSize,
              width: 36.adaptSize,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: appTheme.gray200,
                borderRadius: BorderRadius.circular(
                  100.h,
                ),
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2.5.h,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.adaptSize),
                child: CustomImageView(
                  imagePath: storiesListItemModelObj.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 80,
            height: 20,
            child: Center(
              child: Text(
                storiesListItemModelObj.fullname ?? "null",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.adaptSize),
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
