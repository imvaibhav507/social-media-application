import 'package:get/get.dart';
import '../controller/add_story_controller.dart';

class AddStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStoryController());
  }
}