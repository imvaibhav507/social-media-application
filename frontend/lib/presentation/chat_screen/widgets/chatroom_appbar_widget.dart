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
        height: 16.v,
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
            Container(
                height: 60.v,
                width: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 3)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Obx(
                  ()=> ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:Image.network(
                          chatDetailsModelObj!.avatar!.value ?? '',
                          fit: BoxFit.cover, // Adjust as needed
                        ),
                  ),
                ),
              ),
          ])),
      SizedBox(height: 29.v),
      SizedBox(width: double.maxFinite, child: Divider())
    ]);
  }
}
