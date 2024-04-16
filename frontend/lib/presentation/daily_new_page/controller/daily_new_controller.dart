import 'package:flutter/cupertino.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/like_model.dart';
import 'package:vaibhav_s_application2/presentation/daily_new_page/models/post_model.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/logged_in_user_model.dart';
import 'package:vaibhav_s_application2/repositories/posts_repository.dart';

import '../../../core/app_export.dart';
import '../models/comments_model.dart';

/// A controller class for the DailyNewPage.
///
/// This class manages the state of the DailyNewPage, including the
/// current dailyNewModelObj
class DailyNewController extends GetxController {
  DailyNewController(
      this.postsModelObj, this.likeModelObj, this.commentsModelObj);


  PostsRepository postsRepository = PostsRepository();
  TextEditingController commentController = TextEditingController();
  Rx<PostsModel> postsModelObj;
  Rx<LikeModel> likeModelObj;
  Rx<CommentsModel> commentsModelObj = CommentsModel().obs;

  @override
  void onClose() {
    super.onClose();
    commentController.dispose();
  }

  Future<void> getAllPosts() async {
    await postsRepository.getAllPosts().then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      postsModelObj.value = new PostsModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> likePost(String postId) async {
    await postsRepository.likePost(postId).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      likeModelObj.value = new LikeModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> checkPostLiked(String postId) async {
    await postsRepository.likePost(postId).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      likeModelObj.value = new LikeModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> unlikePost(String postId) async {
    await postsRepository.unlikePost(postId).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<void> getAllComments(String postId) async {
    await postsRepository.getAllComments(postId).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      commentsModelObj = CommentsModel.fromJson(data).obs;
    });
  }

  Future<void> addComment(Post postModel) async {
    var homeScreenController = Get.find<HomeScreenController>();
    await postsRepository
        .addComment(AddCommentModel(
                comment: commentController.value.text, postId: postModel.sId)
            .toJson())
        .then((value) {
      CommentItemModel newComment = new CommentItemModel(
          content: commentController.value.text,
          commentedBy: homeScreenController.loggedInUserModelObj.value.data?.sId,
          avatar: homeScreenController.loggedInUserModelObj.value.data?.avatar,
          fullname: homeScreenController.loggedInUserModelObj.value.data?.fullname,
          createdAt: "Just now");
      commentsModelObj.value.commentItemModelList?.insert(0,newComment);
    });
  }
}
