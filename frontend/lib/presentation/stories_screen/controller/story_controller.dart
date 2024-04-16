import 'package:flutter/cupertino.dart';
import 'package:vaibhav_s_application2/presentation/stories_screen/models/story_model.dart';

import '../../../core/app_export.dart';
import '../../../repositories/posts_repository.dart';

/// A controller class for the ForYouScreen.
///
/// This class manages the state of the ForYouScreen, including the
/// current forYouModelObj
class StoryController extends GetxController {
  StoryController(this.storyModelObj);

  String? postId;
  Rx<StoryModel> storyModelObj = StoryModel().obs;
  TextEditingController commentController = TextEditingController();
  PostsRepository postsRepository = PostsRepository();

  @override
  Future<void> onInit() async {
    super.onInit();
    postId = Get.arguments;
    await getSingleStory(postId!);
  }

  Future<void> getSingleStory(String postId) async {
    await postsRepository.getSingleStory(postId).then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      storyModelObj.value = StoryModel.fromJson(data);
    });
  }

}
