import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/post_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/widgets/post_item_widget.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/daily_new_controller.dart';
import 'models/daily_new_model.dart';

class DailyNewPage extends StatelessWidget {
  DailyNewPage({Key? key})
      : super(
          key: key,
        );

  DailyNewController controller =
      Get.put(DailyNewController(DailyNewModel().obs, PostsModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillPrimary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 28.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.v),
                      Container(
                          child: _buildPostsList()
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget


  Widget _buildPostsList() {
    return Obx(
          ()=> ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(height: 0.v,);
            },
            itemCount: controller.postsModelObj.value.posts!.length,
            itemBuilder: (context, index) {
              Post postModel = controller.postsModelObj.value.posts![index];
              return _buildPostWidget(postModel);
            },
        ),
    );
  }
  /// Section Widget
  Widget _buildPostWidget(Post postModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.v),
      padding: EdgeInsets.all(10.h),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
              height: 2.v,
              thickness: 2.v,
              color: theme.colorScheme.secondaryContainer),
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: postModel.creator!.avatar,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  radius: BorderRadius.circular(
                    25.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.h,
                    top: 8.v,
                    bottom: 3.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        postModel.creator!.fullName!,
                        style: CustomTextStyles.titleLargeBlack900,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        postModel.createdAt!,
                        style: CustomTextStyles.labelMediumBluegray100,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgGrid,
                  height: 6.v,
                  width: 30.h,
                  color: appTheme.black90001,
                  margin: EdgeInsets.symmetric(vertical: 22.v),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.v),
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enableInfiniteScroll: false,
              aspectRatio: 1/1,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
            items: postModel.attachments?.map(
                    (item) => Container(
                      child: PostItemWidget(
                        item,
                      ),
                    )).toList(),
          ),
          SizedBox(height: 12.v),
          Row(
            children: [
              SizedBox(width: 10.h,),
              CustomIconButton(
                height: 35.v,
                width: 35.h,
                decoration: BoxDecoration(
                    color: Colors.transparent
                ),
                child: Image.asset(ImageConstant.imgHeart),
              ),
              SizedBox(width: 22.h,),
              CustomIconButton(
                height: 32.v,
                width: 32.h,
                decoration: BoxDecoration(
                    color: Colors.transparent
                ),
                child: Image.asset(ImageConstant.imgComment),
              ),
              SizedBox(width: 22.h,),
              CustomIconButton(
                height: 32.v,
                width: 32.h,
                decoration: BoxDecoration(
                  color: Colors.transparent
                ),
                child: Image.asset(ImageConstant.imgShare),
              ),
            ],
          ),
          SizedBox(height: 10.v,),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 8.h),
            margin: EdgeInsets.only(right: 8.h),
            child: Text(
              postModel.caption!,
              maxLines: 2,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyLargeBlack90001.copyWith(
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
