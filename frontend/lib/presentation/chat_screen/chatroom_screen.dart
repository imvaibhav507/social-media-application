import 'package:vaibhav_s_application2/presentation/chat_screen/models/chat_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/send_message_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/chatroom_appbar_widget.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/custom_chatscreen_popup_menu_widget.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/message_receiver_widget.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_dialog_box.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/widgets/custom_text_form_field.dart';
import 'controller/chat_controller.dart';

class ChatroomScreen extends GetWidget<ChatController> {
  ChatroomScreen({Key? key}) : super(key: key);
  ChatController controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageConstant.imgChatBkg),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Expanded(
                      // width: double.maxFinite,
                      // height: 730.v,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.h, vertical: 5.v),
                          child: _buildMessagesList())),
                  _buildMessageBoxRow(context),
                ],
              ),
            ))
        // bottomNavigationBar: ),
        );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 100.v,
      centerTitle: true,
      title: Obx(() {
        final chatDetailsModel = controller.chatroomDetailsObj.value;
        if (chatDetailsModel.chatDetails == null) {
          return Text('');
        }
        return ChatroomAppBarWidget(chatDetailsModel.chatDetails!.value);
      }),
      actions: [
        CustomPopupMenuButton(
          onTapShowGroupInfo: onTapShowGroupInfo,
          onTapAddMember: onTapAddMember,
          onTapDeleteGroup: onTapDeleteGroup,
          onTapLeaveGroup: onTapLeaveGroup,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildMessageBoxRow(BuildContext context) {
    return Obx(
        ()=> Padding(
          padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 12.v),
          child: (controller.canMessage.isTrue) ?
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: CustomTextFormField(
                hintText: "Type your message here...".tr,
                controller: controller.textMessageController,
                textInputAction: TextInputAction.done,
                textStyle: CustomTextStyles.titleLargeBlack900,
                hintStyle: CustomTextStyles.titleMediumGray600,
                borderDecoration: TextFormFieldStyleHelper.fillSecondaryContainer,
                fillColor: theme.colorScheme.secondaryContainer,
                suffix: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.attach_file),
                  iconSize: 28.adaptSize,
                ),
                onChanged: (_) {
                  controller.emitTyping();
                },
                onEditingComplete: () {
                  controller.emitStopTyping();
                },
                onTapOutside: (_) {
                  controller.emitStopTyping();
                },
              ),
            ),
            // _buildTextField(),
            Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: CustomIconButton(
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  padding: EdgeInsets.all(13.h),
                  decoration: IconButtonStyleHelper.fillDeepPurpleATL25,
                  onTap: () {
                    onTapSendMessage();
                  },
                  child: CustomImageView(imagePath: ImageConstant.imgGroup9143)),
            )
          ]) : Container(child: Text('You can\'t reply to this conversation anymore',
            style: CustomTextStyles.titleMediumDeeppurpleA200,),)
      ),
    );
  }

  Widget _buildMessagesList() {
    return Obx(() {
      final chatItems = controller.chatScreenModelObj.value.chatItems;
      if (chatItems == null) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      } else if (chatItems.isEmpty) {
        return Center(child: Text("No messages available"));
      }
      return ListView.separated(
          reverse: true,
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.v);
          },
          itemCount: chatItems.length,
          itemBuilder: (context, index) {
            ChatModel model = chatItems[index];
            return MessageReceiverWidget(model);
          });
    });
  }

  /// Navigates to the previous screen.
  onTapClose() {
    Get.back();
  }

  onTapSendMessage() async {
    final sendMessage = SendMessageModel(
      chatroomId: controller.chatroomId,
      message: controller.textMessageController.value.text.toString(),
    );
    controller.textMessageController.clear();

    await controller.sendMessage(sendMessage);
    // await controller.addNewMessage();
    controller.update();
  }

  void onTapShowGroupInfo() {}

  void onTapAddMember() {
    print("tapped");
    Get.toNamed(AppRoutes.addMembersScreen,
        arguments: {'chatroomId': controller.chatroomId});
  }

  Future<void> onTapLeaveGroup() async {
    CustomDialogBox().showDialogBox(
        context: Get.context!,
        title: 'Do you want to leave the group ?',
        onTapNo: () {
          Get.back(closeOverlays: true);
        },
        onTapYes: () async {
          await controller.leaveChatroom();
          Get.back(closeOverlays: true);
        });
  }

  void onTapDeleteGroup() async {
    await controller.deleteGroup();
    print("group deleted");
  }
}

// Align(
// alignment: Alignment.centerLeft,
// child: Padding(
// padding: EdgeInsets.only(right: 111.h),
// child: Row(children: [
// Column(children: [
// CustomImageView(
// imagePath: ImageConstant.img49,
// height: 65.v,
// width: 109.h,
// radius: BorderRadius.only(
// topLeft: Radius.circular(15.h))),
// SizedBox(height: 2.v),
// CustomImageView(
// imagePath: ImageConstant.img50,
// height: 65.v,
// width: 109.h,
// radius: BorderRadius.only(
// bottomLeft: Radius.circular(15.h)))
// ]),
// CustomImageView(
// imagePath: ImageConstant.img51,
// height: 130.v,
// width: 160.h,
// radius: BorderRadius.horizontal(
// right: Radius.circular(15.h)),
// margin: EdgeInsets.only(left: 2.h))
// ]))),
