import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/create_post_page/controller/create_post_controller.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatePostController());
  }
}