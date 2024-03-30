import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/widgets/custom_search_view.dart';
import 'models/recent_searches_model.dart';
import 'widgets/recentsearches_item_widget.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/search_controller.dart';

// ignore_for_file: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key})
      : super(
          key: key,
        );
  SearchController controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 20.v),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildSearchResults(),
                SizedBox(height: 28.v),
                _buildSearchClearAll(),
                SizedBox(height: 24.v),
                _buildRecentSearches(),
              ],
            ),
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
          onChanged: (text) {

          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchClearAll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_recently".tr,
            style: CustomTextStyles.titleLargeDeeppurpleA200Bold,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.v),
            child: Text(
              "lbl_clear_all".tr,
              style: CustomTextStyles.titleMediumDeeppurpleA200,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentSearches() {
    return Obx(
      () => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.v),
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(
                height: 2.v,
                thickness: 2.v,
                color: theme.colorScheme.secondaryContainer,
              ),
            ),
          );
        },
        itemCount:
            controller.searchModelObj.value.recentsearchesItemList.value.length,
        itemBuilder: (context, index) {
          RecentsearchesItemModel model = controller
              .searchModelObj.value.recentsearchesItemList.value[index];
          return RecentsearchesItemWidget(
            model,
          );
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return  ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
            context,
            index,
            ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.v),
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(
                height: 2.v,
                thickness: 2.v,
                color: theme.colorScheme.secondaryContainer,
              ),
            ),
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          RecentsearchesItemModel model = controller
              .searchModelObj.value.recentsearchesItemList.value[index];
          return RecentsearchesItemWidget(
            model,
          );
        },
    );
  }

  onTapBack() {
    Get.back();
  }
}


