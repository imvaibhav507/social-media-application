import '../models/forty_item_model.dart';
import '../controller/daily_new_controller.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

import '../models/post_model.dart';

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
    return SizedBox(
      child: CustomImageView(
          imagePath: attachment,
          radius: BorderRadius.circular(
            16.h,
          ),
        ),
    );
  }
}
