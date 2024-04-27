import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/notifications_page/models/recent_follow_request_model.dart';
class RecentFollowRequestItemWidget extends StatelessWidget {
  RecentFollowRequestItemWidget(this.requestModelObj,{Key? key}):super(key: key);
  RecentRequestModel requestModelObj;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.followRequestsPage);
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.h,
              child: (requestModelObj.count!.value==1)?
              CustomImageView(
                imagePath: requestModelObj.avatars?.first,
                height: 54.v,
                width: 52.h,
                radius: BorderRadius.circular(
                  27.h,
                ),
                margin: EdgeInsets.only(bottom: 26.v),
              ):Stack(
                  children: [
                    CustomImageView(
                      imagePath: requestModelObj.avatars?.first,
                      height: 40.adaptSize,
                      width: 40.adaptSize,
                      radius: BorderRadius.circular(
                        27.h,
                      ),
                      margin: EdgeInsets.only(bottom: 26.v),
                    ),
                    Positioned(
                      left: 8.h,
                      top: 8.v,
                      child: CustomImageView(
                        imagePath: requestModelObj.avatars?.last,
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        radius: BorderRadius.circular(
                          27.h,
                        ),
                        margin: EdgeInsets.only(bottom: 26.v),
                      ),
                    )
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.h,
                bottom: 16.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Follow Requests',
                    style: CustomTextStyles.titleMediumBlack90001,
                  ),
                  SizedBox(height: 7.v),
                  Text(
                    (requestModelObj.count!.value>1)?
                    '@${requestModelObj.username} and ${requestModelObj.count!-1} others':
                    '@${requestModelObj.username}',
                    style: CustomTextStyles.bodyLargeGray600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}