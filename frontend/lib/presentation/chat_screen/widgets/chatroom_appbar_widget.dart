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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                    ()=> AppbarTitle(
                        text: chatDetailsModelObj!.name!.value ?? '',
                        margin: EdgeInsets.only(left: 108.h, top: 8.v, bottom: 6.v)),
                ),
                Container(
                  height: 20.v,
                  width: 180.h,
                  margin: EdgeInsets.only(left: 65.h),
                  child: Obx(() {
                    String members = '';
                    chatDetailsModelObj?.memberDetails?.value
                        .forEach((member) {
                      members = members + '${member.fullname}, ';
                    });
                    print(members);
                    if(controller.typingUser?['user'] == null) {
                      return Text('${members}You', style: CustomTextStyles.bodyLargeGray600, softWrap: true,);
                    }
                    return Container();
                  }),
                ),
                Container(
                  height: 20.v,
                  margin: EdgeInsets.only(left: 100.h),
                  child: Obx(() {
                    if(controller.typingUser?['user'] != null) {
                      return Text('${controller.typingUser?['user']} is typing...', style: CustomTextStyles.bodyLargeGray600,);
                    }
                    return Container();
                  }),
                ),
              ],
            ),
            SizedBox(width: 10.h,),
                Container(
                  height: 52.adaptSize,
                  width: 52.adaptSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CustomImageView(
                    imagePath: chatDetailsModelObj?.avatar?.value ?? '',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
          ])),
    ]);
  }
}
