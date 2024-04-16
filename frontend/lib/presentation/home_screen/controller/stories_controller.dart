import 'package:vaibhav_s_application2/presentation/home_screen/models/stories_model.dart';
import 'package:vaibhav_s_application2/repositories/posts_repository.dart';
import '../../../core/app_export.dart';
import 'package:flutter/material.dart';

/// A controller class for the StoriesPage.
///
/// This class manages the state of the StoriesPage, including the
/// current storiesModelObj
class StoriesController extends GetxController {
  StoriesController(this.storiesListModelObj);

  TextEditingController searchController = TextEditingController();

  PostsRepository postsRepository = PostsRepository();
  Rx<StoriesListModel> storiesListModelObj;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  Future<void> getAllStories() async {
    await postsRepository.getAllStories().then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      storiesListModelObj.value = StoriesListModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
