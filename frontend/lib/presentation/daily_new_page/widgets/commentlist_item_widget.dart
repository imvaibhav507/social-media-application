import 'package:vaibhav_s_application2/presentation/daily_new_page/models/comments_model.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class CommentlistItemWidget extends StatelessWidget {
  CommentlistItemWidget(
    this.commentItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  CommentItemModel commentItemModelObj;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomImageView(
              imagePath: commentItemModelObj.avatar,
              height: 50.adaptSize,
              width: 50.adaptSize,
              radius: BorderRadius.circular(
                25.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.h,
                top: 9.v,
                bottom: 3.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      commentItemModelObj.fullname!,
                      style: CustomTextStyles.titleMediumGray600,
                    ),
                  SizedBox(height: 2.v),
                  Text(
                      commentItemModelObj.createdAt!,
                      style: CustomTextStyles.labelMediumGray500,
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.v),
        SizedBox(
          width: 382.h,
          child: Text(
              commentItemModelObj.content!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyLargeBluegray700.copyWith(
                height: 1.50,
              ),
            ),
          ),
        SizedBox(height: 10.v),
        Text(
            "Reply",
            style: CustomTextStyles.titleMediumDeeppurpleA200SemiBold_1,
          ),
      ],
    );
  }
}
