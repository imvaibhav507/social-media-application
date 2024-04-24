import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';

import '../models/messageslist_item_model.dart';
import '../controller/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class MessageslistItemWidget extends StatelessWidget {

  MessageslistItemWidget(
    this.messageslistItemModelObj, this.currentIndex, {
    Key? key,
  }) : super(
          key: key,
        );

  MessagesItemModel messageslistItemModelObj;

  int currentIndex;

  var controller = Get.find<MessagesController>();
  var homeScreenController = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.adaptSize),
        color: (currentIndex.isEven)? appTheme.indigo100:appTheme.gray200
      ),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 8.h, vertical: 3.v),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 20.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 54.v,
            width: 52.h,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: messageslistItemModelObj.avatar!.value,
                  height: 54.v,
                  width: 52.h,
                  radius: BorderRadius.circular(
                    27.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Obx(
                    ()=> (messageslistItemModelObj.isGroupChat?.value == false &&
                        homeScreenController.onlineUsers.contains(messageslistItemModelObj.otherMembers?.first))?
                    Container(
                      height: 13.adaptSize,
                      width: 13.adaptSize,
                      decoration: BoxDecoration(
                        color: appTheme.green600,
                        borderRadius: BorderRadius.circular(
                          6.h,
                        ),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 2.h,
                        ),
                      ),
                    ): Container()
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 2.v,
              bottom: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    messageslistItemModelObj.name?.value ?? '',
                    style: CustomTextStyles.titleLargeBlack900,
                  ),
                ),
                SizedBox(height: 8.v),
                Obx(
                  () => Text(
                    messageslistItemModelObj.lastMessage?.value ?? '',
                    style: CustomTextStyles.bodyLargeBlack90001,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 3.v,
              bottom: 30.v,
            ),
            child: Obx(
              () => Text(
                messageslistItemModelObj.time?.value ?? '',
                style: CustomTextStyles.bodyLargeBlack90001,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
