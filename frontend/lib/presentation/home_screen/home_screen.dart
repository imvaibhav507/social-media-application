import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/widgets/storieslist_item_widget.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/widgets/user_story_item_widget.dart';
import 'package:vaibhav_s_application2/presentation/trending_page/trending_page.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/daily_new_page.dart';
import 'package:vaibhav_s_application2/presentation/discover_page/discover_page.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/stories_controller.dart';
import 'models/stories_model.dart';
import 'models/storieslist_item_model.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );
  HomeScreenController controller = Get.put(HomeScreenController());
  StoriesController storiesController =
      Get.put(StoriesController(StoriesModel().obs));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [_buildAppBar()];
        },
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 29.v),
              _buildTabview(),
              Expanded(
                child: TabBarView(
                  controller: controller.tabviewController,
                  children: [
                    TrendingPage(),
                    DailyNewPage(),
                    DiscoverPage(),
                    DailyNewPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  /// Section Widget
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      toolbarHeight: 170.v,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              "lbl_stories".tr,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 20.v),
          _buildStoriesList(),
        ],
      ),
      // actions: [
      //   AppbarTrailingImage(
      //     imagePath: ImageConstant.imgPlay40x40,
      //     margin: EdgeInsets.fromLTRB(16.h, 5.v, 19.h, 5.v),
      //   ),
      // ],
    );
  }

  /// Section Widget
  Widget _buildTabview() {
    return Container(
      height: 30.v,
      width: 410.h,
      child: TabBar(
        controller: controller.tabviewController,
        isScrollable: true,
        labelColor: appTheme.deepPurpleA200,
        unselectedLabelColor: appTheme.indigo100,
        tabs: [
          Tab(
            child: Text(
              "lbl_trending".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_latest".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_discover".tr,
            ),
          ),
          Tab(
            child: Text(
              "lbl_daily_new".tr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourStoryItem() {
    return UserStoryItemWidget(
        storiesController.storiesModelObj.value.storieslistItemList.value[3]);
  }

  /// Section Widget
  Widget _buildStoriesList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: double.maxFinite,
        height: 94.v,
        child: Obx(
          () => ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                width: 16.h,
              );
            },
            itemCount: storiesController
                .storiesModelObj.value.storieslistItemList.value.length,
            itemBuilder: (context, index) {
              if(index==0) return _buildYourStoryItem();
              else {
                StorieslistItemModel model = storiesController
                    .storiesModelObj.value.storieslistItemList.value[index];
                return StorieslistItemWidget(
                  model,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
