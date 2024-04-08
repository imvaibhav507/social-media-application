import 'package:vaibhav_s_application2/presentation/daily_new_page/models/post_model.dart';
import 'package:vaibhav_s_application2/repositories/posts_repository.dart';

import '../../../core/app_export.dart';
import '../models/daily_new_model.dart';

/// A controller class for the DailyNewPage.
///
/// This class manages the state of the DailyNewPage, including the
/// current dailyNewModelObj
class DailyNewController extends GetxController {
  DailyNewController(this.dailyNewModelObj, this.postsModelObj);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPosts();
  }
  PostsRepository postsRepository = PostsRepository();
  Rx<DailyNewModel> dailyNewModelObj;

  Rx<PostsModel> postsModelObj;


  Future<void> getAllPosts() async{
    await postsRepository.getAllPosts()
        .then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      postsModelObj.value = new PostsModel.fromJson(data);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
