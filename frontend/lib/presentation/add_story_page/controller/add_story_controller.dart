import 'package:camera/camera.dart';
import '../../../core/app_export.dart';
import '../../../repositories/posts_repository.dart';

class AddStoryController extends GetxController {

  late List<XFile> capturedImages;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    capturedImages = Get.arguments!;
  }

  PostsRepository postsRepository = PostsRepository();

  Future<void> addStory() async {
    await postsRepository.addStory(capturedImages, "attachments").then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      Get.offAllNamed(AppRoutes.containerScreen);
    });
  }

}