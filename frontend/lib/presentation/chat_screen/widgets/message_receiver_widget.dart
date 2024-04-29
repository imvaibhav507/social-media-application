import 'package:flutter/cupertino.dart';
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
                  decoration: AppDecoration.white.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderTL15),
                  constraints: BoxConstraints(maxWidth: 270.h, minWidth: 100.h),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        (controller.isGroupChat == true)? Text(chatModelObj.name!.value, style: CustomTextStyles.bodyLargePrimary.copyWith(
                            height: 1.50, fontWeight: FontWeight.w600)) : Container(width: 0,),
                        SizedBox(height: 4.h,),
                        Text(chatModelObj.content!.value,
                            softWrap: true,
                            style: CustomTextStyles.bodyLargePrimary.copyWith(
                                height: 1.50, fontWeight: FontWeight.w500)),
                        Text(chatModelObj.time!.value, style: CustomTextStyles.labelMediumPrimary,)
                      ]))
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.v),
                  decoration: AppDecoration.fillGray.copyWith(
                      borderRadius: BorderRadiusStyle.customBorderBL15),
                  constraints: BoxConstraints(maxWidth: 270.h, minWidth: 100.h),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (controller.isGroupChat == true)? Text(chatModelObj.name!.value, style: CustomTextStyles.bodyLargeBlack90001.copyWith(
                            height: 1.50, fontWeight: FontWeight.w600)):Container(width: 0,),
                        SizedBox(height: 4.h,),
                        Container(
                            margin: EdgeInsets.only(right: 6.h),
                            child: Text(chatModelObj.content!.value,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.bodyLargeBlack90001
                                    .copyWith(
                                        height: 1.50,
                                        fontWeight: FontWeight.w500))),
                        Text(chatModelObj.time!.value, style: CustomTextStyles.labelMediumGray500,)
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
