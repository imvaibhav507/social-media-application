import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:vaibhav_s_application2/widgets/custom_drop_down_menu.dart';
import 'widgets/stories1_item_widget.dart';
import 'models/stories1_item_model.dart';
import 'widgets/messageslist_item_widget.dart';
import 'models/messageslist_item_model.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/messages_controller.dart';
import 'models/messages_model.dart';

// ignore_for_file: must_be_immutable
class MessagesPage extends StatelessWidget {
  MessagesPage({Key? key}) : super(key: key);

  MessagesController controller =
      Get.put(MessagesController(MessageslistModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 15.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildStories(),
                      // SizedBox(height: 23.v),
                      _buildMessagesList()
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        leadingWidth: 250.h,
        height: 80.v,
        leading:Padding(
            padding: EdgeInsets.all(16.adaptSize),
            child: Text("lbl_messages".tr,
                style: theme.textTheme.headlineLarge)),
        actions: [
          IconButton(onPressed: () async{
            await controller.getChatroomList();
          }, icon: Icon(Icons.tap_and_play_outlined)),
          AppbarTrailingImage(
            onTap: onTapSearchPage,
              imagePath: ImageConstant.imgSearch,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v)),
          CustomPopupMenuButton()
        ]);
  }

  /// Section Widget
  Widget _buildMessagesList() {
    return Expanded(

      child: Obx(() {
        final messagesListModel = controller.messagesListModelObj.value;
        if (messagesListModel.messagesItems == null) {
          // Show a loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator(color: Colors.black,));
        } else if (messagesListModel.messagesItems!.value.isEmpty) {
          // Show a message if there are no messages
          return Center(child: Text("No messages available"));
        }
        return ListView.separated(
        scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {

            return SizedBox(
                width: double.maxFinite,
                child: Divider(
                    height: 2.v,
                    thickness: 2.v,
                    color: theme.colorScheme.secondaryContainer));
          },
          itemCount: messagesListModel.messagesItems!.value.length,
          itemBuilder: (context, index) {
            MessagesItemModel model = messagesListModel.messagesItems!.value[index];
            String chatRoomId = messagesListModel.messagesItems!.value[index].sId!.value;
            return GestureDetector(
              onTap: ()=>Get.toNamed(AppRoutes.chatScreen, arguments: chatRoomId),
                child: MessageslistItemWidget(model,));
          });
      }),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowBack() {
    Get.back();
  }

  onTapSearchPage() {

    Get.toNamed(AppRoutes.chatsSearchScreen);
  }
}
