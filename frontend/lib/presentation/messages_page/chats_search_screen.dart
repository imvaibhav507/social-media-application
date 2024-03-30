import 'package:vaibhav_s_application2/presentation/messages_page/models/search_chatroom_model.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/widgets/found_chatrooms_Item_widget.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/custom_search_view.dart';
import 'controller/chats_search_controller.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ChatsSearchScreen extends StatelessWidget {
  ChatsSearchScreen({Key? key})
      : super(
          key: key,
        );
  SearchChatroomsController controller = Get.put(SearchChatroomsController());
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
              // _buildSearchClearAll(),
              // SizedBox(height: 24.v),
              // _buildRecentSearches(),
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
        margin: EdgeInsets.all(12.0)
      ),
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomSearchView(
          textStyle: CustomTextStyles.titleLargeBlack900,
          hintStyle: CustomTextStyles.titleLargeGray500,
          alignment: Alignment.bottomCenter,
          controller: controller.searchController,
          hintText: "lbl_search".tr,
          onChanged: (text)=> onChangedGetSearchResults(text),
        ),
      ),
    );
  }

  /// Section Widget
  // Widget _buildSearchClearAll() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16.h),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           "lbl_recently".tr,
  //           style: CustomTextStyles.titleLargeDeeppurpleA200Bold,
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 4.v),
  //           child: Text(
  //             "lbl_clear_all".tr,
  //             style: CustomTextStyles.titleMediumDeeppurpleA200,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  // Widget _buildRecentSearches() {
  //   return Obx(
  //     () => ListView.separated(
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       separatorBuilder: (
  //         context,
  //         index,
  //       ) {
  //         return Padding(
  //           padding: EdgeInsets.symmetric(vertical: 8.0.v),
  //           child: SizedBox(
  //             width: double.maxFinite,
  //             child: Divider(
  //               height: 2.v,
  //               thickness: 2.v,
  //               color: theme.colorScheme.secondaryContainer,
  //             ),
  //           ),
  //         );
  //       },
  //       itemCount:
  //           controller.searchModelObj.value.recentsearchesItemList.value.length,
  //       itemBuilder: (context, index) {
  //         RecentsearchesItemModel model = controller
  //             .searchModelObj.value.recentsearchesItemList.value[index];
  //         return RecentsearchesItemWidget(
  //           model,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildSearchResults() {
    return Expanded(
      child: Obx((){
        final searchResultListModel = controller.searchChatroomModelObj.value;
        if (controller.isLoading==true) {
          // Show a loading indicator while data is being fetched
          return Center(child: CircularProgressIndicator(color: Colors.black,));
        }else if(searchResultListModel.foundChatrooms==null){
          return Center();
        } else if (searchResultListModel.foundChatrooms!.isEmpty) {
          return Center(child: Text("Nothing found", style: CustomTextStyles.titleLargeBlack900,));
        }
        return  ListView.separated(
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
          itemCount: searchResultListModel.foundChatrooms!.length,
          itemBuilder: (context, index) {
            FoundChatroom model = searchResultListModel.foundChatrooms![index];
            return InkWell(
              onTap:()=> onTapGotoChatroom(model.sId!.value),
                child: FoundChatroomItemWidget(model,));
          },
        );
      }),
    );

  }

  onTapBack() {
    Get.back();
  }

  onChangedGetSearchResults(String text) {
      controller.getSearchResults(text);
  }

  void onTapGotoChatroom(String chatroomId) {
    Get.offNamed(AppRoutes.chatScreen, arguments: chatroomId);
  }
}


