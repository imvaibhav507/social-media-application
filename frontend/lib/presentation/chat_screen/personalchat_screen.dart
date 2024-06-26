
import 'package:flutter/cupertino.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/chat_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/models/send_message_model.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/chatroom_appbar_widget.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/custom_chatscreen_popup_menu_widget.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/message_receiver_widget.dart';
import 'package:vaibhav_s_application2/presentation/chat_screen/widgets/personal_chat_appbar_widget.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/widgets/custom_text_form_field.dart';
import 'controller/chat_controller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class PersonalChatScreen extends GetWidget<ChatController> {
  PersonalChatScreen({Key? key}) : super(key: key);
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
                  image: DecorationImage(image: AssetImage(ImageConstant.imgChatBkg),fit: BoxFit.cover)
              ),
              child: Column(
                children: [
                  Expanded(
                    // width: double.maxFinite,
                    // height: 730.v,
                      child:Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 5.v),
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
      height: 90.v,
      centerTitle: true,
      title: Obx(() {
        final chatDetailsModel = controller.personalChatDetailsObj;
        if (chatDetailsModel.value == null) {
          return Text('');
        }
        return PersonalChatAppBarWidget(chatDetailsModel.value.memberDetailsModel);
      }),
      actions: [
        IconButton(onPressed: () {}, icon:Icon(CupertinoIcons.ellipsis_vertical))
      ],
    );
  }

  /// Section Widget
  Widget _buildMessageBoxRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 12.v),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                onPressed: () {
                },
                icon: Icon(Icons.attach_file),iconSize: 28.adaptSize,),
              onChanged: (_) {
                controller.emitTyping();
              },
              onEditingComplete: () {
                controller.emitStopTyping();
              },
              onTapOutside: (_){
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
                onTap: (){onTapSendMessage();},
                child:
                CustomImageView(imagePath: ImageConstant.imgGroup9143)),
          )
        ]));
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

  onTapSendMessage() async{
    final sendMessage = SendMessageModel(
      chatroomId: controller.chatroomId,
      message: controller.textMessageController.value.text.toString(),
    );
    controller.textMessageController.clear();

    await controller.sendMessage(sendMessage);
    controller.update();
  }
}