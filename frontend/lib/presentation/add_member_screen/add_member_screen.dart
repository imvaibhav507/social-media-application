import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/presentation/add_member_screen/controller/add_members_controller.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/models/search_chatroom_model.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/widgets/found_chatrooms_Item_widget.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/custom_search_view.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

import 'models/search_users_model.dart';
import 'widgets/found_users_item_widget.dart';

// ignore_for_file: must_be_immutable
class AddMemberScreen extends StatelessWidget {
  AddMemberScreen({Key? key})
      : super(
          key: key,
        );
  AddMemberController controller = Get.find<AddMemberController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 20.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchResults(),
              _buildToBeAddedList()
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 70.v,
      leadingWidth: 50.h,
      leading: AppbarLeadingImage(
          onTap: onTapBack,
          imagePath: ImageConstant.imgVector,
          margin: EdgeInsets.all(12.0)),
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomSearchView(
          textStyle: CustomTextStyles.titleLargeBlack900,
          hintStyle: CustomTextStyles.titleLargeGray500,
          alignment: Alignment.bottomCenter,
          // controller: controller.searchController,
          hintText: "lbl_search".tr,
          onChanged: (text) => onChangedGetSearchResults(
              chatroomId: controller.chatroomId!, searchQuery: text.toString()),
        ),
      ),
      actions: [
        Container(
          child: Obx((){
            if(controller.userModels.isNotEmpty) {
              return IconButton(
                icon: Icon(Icons.done),
                onPressed: onPressedAddMembers,
              );
            }
            return Container();
          }),
        )
      ],
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      flex: 5,
      child: Obx(() {
        final searchResultListModel = controller.searchUsersModelObj.value;
        if (controller.isLoading == true) {
          // Show a loading indicator while data is being fetched
          return Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (searchResultListModel.users == null) {
          return Center();
        } else if (searchResultListModel.users!.isEmpty) {
          return Center(
              child: Text(
            "Nothing found",
            style: CustomTextStyles.titleLargeBlack900,
          ));
        }
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: double.maxFinite,
              child: Divider(
                height: 1.v,
                thickness: 2.v,
                color: theme.colorScheme.secondaryContainer,
              ),
            );
          },
          itemCount: searchResultListModel.users!.length,
          itemBuilder: (context, index) {
            User model = searchResultListModel.users![index];
            return FoundUsersItemWidget(
              model,
            );
          },
        );
      }),
    );
  }

  onTapBack() {
    Get.back();
  }

  onChangedGetSearchResults(
      {required String chatroomId, required String searchQuery}) {
    controller.getFoundUsersList(chatroomId, searchQuery);
  }

  Widget _buildToBeAddedList() {
    return Expanded(
      flex: 1,
      child: Obx(
        () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.userModels.length,
            itemBuilder: (context, index) {
              final models = controller.userModels;
              return GestureDetector(
                onTap: () => controller.userModels.remove(models[index]),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomImageView(
                      imagePath: models[index].avatar,
                      height: 54.v,
                      width: 52.h,
                      radius: BorderRadius.circular(
                        27.h,
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 35.adaptSize,
                        width: 35.adaptSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20.h,
                          ),
                          border: Border.all(
                            color: theme.colorScheme.primary,
                            width: 2.h,
                          ),
                        ),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey.shade500,
                          size: 35.adaptSize,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void onPressedAddMembers() {
    
  }
}
