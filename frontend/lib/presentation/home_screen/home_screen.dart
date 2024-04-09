import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/widgets/storieslist_item_widget.dart';
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
              SizedBox(height: 16.v),
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
      toolbarHeight: 220.v,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Text(
                  "lbl_stories".tr,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgNavNotificationsDeepPurpleA200,
                onTap: ()=> Get.toNamed(AppRoutes.notificationsPage),
              )
            ],
          ),
          _buildProfilesList(),
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
      height: 50.v,
      child: TabBar(
        controller: controller.tabviewController,
        isScrollable: true,
        splashBorderRadius: BorderRadius.circular(10),
        labelColor: appTheme.deepPurpleA200,
        unselectedLabelColor: appTheme.indigo100,
        labelStyle: CustomTextStyles.titleMediumDeeppurpleA200SemiBold,
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

  Widget _buildProfilesList() {
    return SizedBox(
      height: 150.v,
      child: Obx(
            () => ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
              context,
              index,
              ) {
            return SizedBox(
              width: 16.h,
            );
          },
          itemCount: storiesController.storiesModelObj.value.storiesListItemList.value.length,
          itemBuilder: (context, index) {
            StoriesListItemModel model = storiesController.storiesModelObj.value
                .storiesListItemList.value[index];
            return GestureDetector(
              onTap: onTapOpenStories,
              child: Profileslist1ItemWidget(
                model,
              ),
            );
          },
        ),
      ),
    );
  }

  void onTapOpenStories() {
    Get.toNamed(AppRoutes.forYouScreen);
  }

}
