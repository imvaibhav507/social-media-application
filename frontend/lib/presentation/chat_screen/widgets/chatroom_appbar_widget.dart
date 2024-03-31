import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/controller/chat_controller.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chatroom_details_model.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_title_image.dart';

class ChatroomAppBarWidget extends StatelessWidget {
  ChatroomAppBarWidget(
      this.chatDetailsModelObj,
      {Key? key}) : super(key: key);

  ChatDetailsModel? chatDetailsModelObj;

  var controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    if (chatDetailsModelObj == null) {
      return SizedBox(); // Return an empty widget if chatDetailsModelObj is null
    }
    return Column(children: [
      SizedBox(
        height: 28.v,
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            AppbarTitleImage(
                imagePath: ImageConstant.imgClose,
                margin: EdgeInsets.symmetric(vertical: 8.v),
                onTap: () {
                  Get.back();
                }),
            Obx(
                ()=> AppbarTitle(
                    text: chatDetailsModelObj!.name!.value ?? '',
                    margin: EdgeInsets.only(left: 108.h, top: 8.v, bottom: 6.v)),
            ),
            SizedBox(width: 10.h,),
                CustomImageView(
                  imagePath: chatDetailsModelObj!.avatar!.value,
                  height: 54.v,
                  width: 52.h,
                  radius: BorderRadius.circular(
                    27.h,
                  ),
                  border: Border.all(width: 0.95),
                  alignment: Alignment.center,
                ),
          ])),
      SizedBox(height: 29.v),
      SizedBox(width: double.maxFinite, child: Divider())
    ]);
  }
}
