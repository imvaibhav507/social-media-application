import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/stories_screen/models/story_model.dart';
import '../controller/story_controller.dart';
/// A binding class for the ForYouScreen.
///
/// This class ensures that the ForYouController is created when the
/// ForYouScreen is first loaded.
class StoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoryController(StoryModel().obs));
  }
}
