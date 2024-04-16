import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/stories_screen/controller/stories_controller.dart';
import '../models/stories_model.dart';

/// A binding class for the ForYouScreen.
///
/// This class ensures that the ForYouController is created when the
/// ForYouScreen is first loaded.
class StoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoriesController());
  }
}
