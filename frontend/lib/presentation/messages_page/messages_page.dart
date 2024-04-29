import 'package:flutter/cupertino.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/widgets/custom_drop_down_menu.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import 'package:vaibhav_s_application2/widgets/custom_text_form_field.dart';
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
            body: RefreshIndicator(
              color: appTheme.deepPurpleA200,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: refresh,
              child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMessagesList()
                      ])),
            )));
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
          AppbarTrailingImage(
            onTap: onTapSearchPage,
              imagePath: ImageConstant.imgSearch,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v)),
          CustomPopupMenuButton(
            onTapCreateGroup: () {
              openCreateGroupDialogBox();
            },
          )
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
        } else if (messagesListModel.messagesItems!.isEmpty) {
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
                    thickness: 3.v,
                    color: theme.colorScheme.secondaryContainer));
          },
          itemCount: messagesListModel.messagesItems!.length,
          itemBuilder: (context, index) {
            MessagesItemModel model = messagesListModel.messagesItems![index];
            return GestureDetector(
              onTap: (){
                  Get.toNamed(
                      (model.isGroupChat?.value == true)?AppRoutes.chatroomScreen
                          :AppRoutes.personalChatScreen,
                      arguments: {'chatroomId':model.sId?.value, 'isGroupChat': model.isGroupChat?.value,}
                  );
              },
                child: MessageslistItemWidget(model,index));
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

  openCreateGroupDialogBox() {
    return showDialog(
        context: Get.context!, 
        builder: (context) {
          return Center(
            child: SizedBox(
              height: 200.v,
              width: 300.h,
              child: Container(
                padding: EdgeInsets.all(16.adaptSize),
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadius.circular(12.adaptSize)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Create new group', style: CustomTextStyles.titleLargeBlack900,),
                    SizedBox(height: 12.v,),
                    Card(
                      child: CustomTextFormField(
                        hintText: "Group name".tr,
                        controller: controller.groupNameController,
                        textInputAction: TextInputAction.done,
                        textStyle: CustomTextStyles.titleLargeBlack900,
                        hintStyle: CustomTextStyles.titleMediumGray600,
                        borderDecoration: TextFormFieldStyleHelper.fillSecondaryContainer,
                        fillColor: theme.colorScheme.secondaryContainer,
                      ),
                    ),
                    SizedBox(height: 12.v,),
                    CustomIconButton(
                      width: 100.h,
                      height: 40.v,
                      child: Center(child: Text('Continue', style: CustomTextStyles.bodyLargePrimary,)),
                      onTap: (){
                        Get.back();
                        onTapGoToAddMembers();
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  onTapGoToAddMembers() {
    String? groupName = controller.groupNameController.value.text.trim();
    if(!(groupName == null || groupName.isEmpty) ) {
      Get.toNamed(AppRoutes.addMembersScreen,
          arguments: {'chatroomId':'0B37019D9DE69C400C95D8F0', 'groupName':groupName});
    }
    controller.groupNameController.clear();
  }

  Future<void> refresh() async{
    await Future.delayed(Duration(seconds: 2));
    controller.messagesListModelObj = MessageslistModel().obs;
    controller.getChatroomList();
    controller.getSingleChatroomListItem();;
  }
}
