import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/controller/chat_controller.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chat_model.dart';

class MessageReceiverWidget extends StatelessWidget {
  MessageReceiverWidget(this.chatModelObj, {Key? key}) : super(key: key);
  ChatModel chatModelObj;
  var controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: (controller.userId! == chatModelObj.senderId!.value)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6.v),
          (controller.userId! == chatModelObj.senderId!.value)
              ? Container(
                  margin: EdgeInsets.only(left: 100.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.v),
                  decoration: AppDecoration.white.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL15),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.v),
                        Text(chatModelObj.content!.value,
                            style: theme.textTheme.titleMedium),
                      ]))
              : Container(
                  margin: EdgeInsets.only(right: 96.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 23.h, vertical: 12.v),
                  decoration: AppDecoration.fillDeepPurple.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBL15),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.v),
                        Container(
                            margin: EdgeInsets.only(right: 19.h),
                            child: Text(chatModelObj.content!.value,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles
                                    .titleMediumDeeppurpleA200
                                    .copyWith(height: 1.50)))
                      ])),
          SizedBox(height: 9.v),
          if (controller.userId! == chatModelObj.senderId!.value)
            _buildDeliveredRow(deliveredText: "lbl_delivered".tr),
        ]);
  }

  Widget _buildDeliveredRow({required String deliveredText}) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Obx(() {
        final substring = chatModelObj.sId?.value.substring(0, 7);
        return Text((substring == 'sending') ? "Sending... " : deliveredText,
            style: CustomTextStyles.bodySmallGray600
                .copyWith(color: appTheme.gray600));
      }),
      Obx(() {
        final substring = chatModelObj.sId?.value.substring(0, 7);
        if (substring == 'sending') {
          return Container(
              height: 10.adaptSize,
              width: 10.adaptSize,
              padding: EdgeInsets.all(2.adaptSize),
              child: CircularProgressIndicator(
                color: appTheme.gray500,
                strokeWidth: 1.2.adaptSize,
              ));
        }
        return CustomImageView(
            imagePath: ImageConstant.imgSettingsDeepPurpleA200,
            height: 10.v,
            width: 15.h,
            margin: EdgeInsets.only(left: 12.h, top: 2.v, bottom: 2.v));
      })
    ]);
  }
}
