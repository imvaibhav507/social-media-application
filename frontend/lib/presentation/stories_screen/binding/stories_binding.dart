import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/home_screen/models/stories_model.dart';
import '../../home_screen/controller/stories_controller.dart';

/// A binding class for the ForYouScreen.
///
/// This class ensures that the ForYouController is created when the
/// ForYouScreen is first loaded.
class StoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoriesController(StoriesModel().obs));
  }
}
