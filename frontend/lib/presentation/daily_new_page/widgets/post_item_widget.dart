import '../controller/daily_new_controller.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
// ignore: must_be_immutable
class PostItemWidget extends StatelessWidget {
  PostItemWidget(
    this.attachment, {
    Key? key,
  }) : super(
          key: key,
        );

  String attachment;

  var controller = Get.find<DailyNewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.adaptSize),
      ),
      child: CustomImageView(
          imagePath: attachment,
        ),
    );
  }
}
