import 'package:carousel_slider/carousel_slider.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/post_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/widgets/commentlist_item_widget.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/widgets/post_item_widget.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/widgets/custom_text_form_field.dart';
import 'controller/daily_new_controller.dart';
import 'models/comments_model.dart';
import 'models/like_model.dart';

class DailyNewPage extends StatelessWidget {
  DailyNewPage({Key? key})
      : super(
          key: key,
        );

  DailyNewController controller =
      Get.find<DailyNewController>();
  RxBool bottomSheetOpened = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          ()=> Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPostsList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget


  Widget _buildPostsList() {
    var postsModelObj = controller.postsModelObj.value.posts;
    if(postsModelObj == null || postsModelObj.isEmpty) {
      return Center(
        heightFactor: 20.v,
        child: Text('No Posts Available', style: CustomTextStyles.titleLargeBlack900,),
      );
    }
    return Obx(
          ()=> ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(height: 0.v,);
            },
            itemCount: postsModelObj.length,
            itemBuilder: (context, index) {
              return _buildPostWidget(postsModelObj[index]);
            },
        ),
    );
  }
  /// Section Widget
  Widget _buildPostWidget(Post postModel) {
    print(postModel.isLikedBy?.value);
    return Container(
      padding: EdgeInsets.all(4.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 4.v,
            color: appTheme.gray50
          )
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: postModel.creator!.avatar,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  radius: BorderRadius.circular(
                    30.h,
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
                        postModel.creator?.fullName ?? "null",
                        style: CustomTextStyles.titleLargeBlack900,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        postModel.createdAt ?? "null",
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
          CarouselSlider(
            options: CarouselOptions(
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
              Obx(
                  ()=> CustomIconButton(
                    height: 35.v,
                    width: 35.h,
                    decoration: BoxDecoration(
                        color: Colors.transparent
                    ),
                    onTap: (){
                      onTapLikePost(postModel);
                    },
                    child: (postModel.isLikedBy?.value == true)?
                    Image.asset(ImageConstant.imgLikedHeart):
                    Image.asset(ImageConstant.imgHeart)),
              )
              ,

              SizedBox(width: 22.h,),
              CustomIconButton(
                height: 32.v,
                width: 32.h,
                decoration: BoxDecoration(
                    color: Colors.transparent
                ),
                onTap: () async {
                  await controller.getAllComments(postModel.sId!);
                  onTapShowBottomSheet(postModel);
                },
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
            padding: EdgeInsets.symmetric(vertical: 12.v, horizontal: 8.h),
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

  onTapLikePost(Post postModel) async{
    if(postModel.isLikedBy?.value == true) {
      postModel.isLikedBy?.value = false;
      await controller.unlikePost(postModel.sId!);
      return;
    }
    else {
      postModel.isLikedBy?.value = true;
      await controller.likePost(postModel.sId!);
      return;
    }
  }

  onTapShowBottomSheet(Post postModel) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
        context: Get.context!, builder: (_){
        return Container(
          width: double.infinity,
          height: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.adaptSize),
                  child: Text(
                    "Comments",
                    style: CustomTextStyles.titleLargeDeeppurpleA200,
                  ),
                ),
                // Container(
                //   height: 200.v,
                //     child: Center(child: Text('No Comments', style: CustomTextStyles.titleLargeBlack900,))),
                _buildCommentsList(),
                _buildCommentBox(Get.context!, postModel)
              ],
            ),
          ),
        );
    },);
  }

  Widget _buildCommentBox(BuildContext context, Post postModel) {
    return Padding(
        padding: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 12.v),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: CustomTextFormField(
              hintText: "Add your comment here...".tr,
              controller: controller.commentController,
              textInputAction: TextInputAction.done,
              textStyle: CustomTextStyles.titleLargeBlack900,
              hintStyle: CustomTextStyles.titleMediumGray600,
              borderDecoration: TextFormFieldStyleHelper.fillSecondaryContainer,
              fillColor: theme.colorScheme.secondaryContainer,

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
                onTap: (){
                  onTapAddComment(postModel);
                },
                child:
                CustomImageView(imagePath: ImageConstant.imgGroup9143)),
          )
        ]));
  }

  Widget _buildCommentsList() {
    return Obx(
          () => Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                    separatorBuilder: (
              context,
              index,
              ) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.v),
              child: SizedBox(
                width: 382.h,
                child: Divider(
                  height: 2.v,
                  thickness: 2.v,
                  color: theme.colorScheme.secondaryContainer,
                ),
              ),
            );
                    },
                    itemCount:
                    controller.commentsModelObj.value.commentItemModelList!.length,
                    itemBuilder: (context, index) {
            CommentItemModel model = controller
                .commentsModelObj.value.commentItemModelList![index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 10.v),
              child: CommentlistItemWidget(
                model,
              ),
            );
                    },
                  ),
          ),
    );
  }

  void onTapAddComment(Post postModel) async {
    await controller.addComment(postModel);
    controller.commentController.clear();
  }

}
