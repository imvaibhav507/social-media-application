import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/widgets/storieslist_item_widget.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/daily_new_page.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/stories_controller.dart';
import 'models/stories_model.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );
  HomeScreenController controller = Get.put(HomeScreenController());
  StoriesController storiesController =
      Get.put(StoriesController(StoriesListModel().obs));
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
              SizedBox(height: 6.v),
              _buildTabview(),
              Expanded(
                child: TabBarView(
                  controller: controller.tabviewController,
                  children: [
                    DailyNewPage(),
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
      toolbarHeight: 190.v,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 15.v),
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
                onTap: () => Get.toNamed(AppRoutes.notificationsPage),
              )
            ],
          ),
          _buildProfilesList(),
          SizedBox(height: 20.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview() {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 55.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(16.h),),
        boxShadow: [
          BoxShadow(
            color: appTheme.deepPurpleA200.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              12,
            ),
          ),
        ],
      ),
      child: TabBar(
        controller: controller.tabviewController,
        isScrollable: true,
        splashBorderRadius: BorderRadius.circular(10),
        labelColor: appTheme.deepPurpleA200,
        unselectedLabelColor: appTheme.indigo100,
        indicatorColor: appTheme.deepPurpleA200,
        tabAlignment: TabAlignment.center,
        labelStyle: CustomTextStyles.titleMediumDeeppurpleA200SemiBold,
        tabs: [
          Tab(
            child: Text(
              "lbl_latest".tr,
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
      height: 135.v,
      child: Obx(() {
        if (storiesController.storiesListModelObj.value.storiesListModel ==
                null ||
            storiesController
                .storiesListModelObj.value.storiesListModel!.isEmpty) {
          return Container();
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 8.h,
            );
          },
          itemCount: storiesController
                  .storiesListModelObj.value.storiesListModel!.length +
              1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildAddStoryWidget();
            }
            StoriesListItemModel model = storiesController
                    .storiesListModelObj.value.storiesListModel?[index - 1] ??
                StoriesListItemModel();
            return GestureDetector(
              onTap: () {
                onTapOpenStories(model.sId);
              },
              child: Profileslist1ItemWidget(
                model,
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildAddStoryWidget() {
    return GestureDetector(
      onTap: () {
        print("tapped");
        Get.toNamed(AppRoutes.captureImageScreen);
      },
      child: SizedBox(
        height: 130.v,
        width: 70.h,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CustomImageView(
              imagePath: controller.loggedInUserModelObj.value.data?.avatar,
              height: 75.v,
              width: 60.h,
              fit: BoxFit.cover,
              radius: BorderRadius.circular(
                15.h,
              ),
              alignment: Alignment.center,
            ),
            Positioned(
              right: 36,
              top: 64,
              child: Container(
                height: 36.adaptSize,
                width: 36.adaptSize,
                decoration: BoxDecoration(
                  color: appTheme.gray200,
                  borderRadius: BorderRadius.circular(
                    100.h,
                  ),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 4.h,
                  ),
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgAddStory,
                ),
              ),
            ),
            Container(
              width: 80,
              height: 20,
              child: Center(
                child: Text(
                  "Add Story",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 16.adaptSize),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onTapOpenStories(String? postId) {
    Get.toNamed(AppRoutes.storyScreen, arguments: postId);
  }
}
