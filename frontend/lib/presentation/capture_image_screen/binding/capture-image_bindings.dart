import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/capture_image_screen/controller/capture_image_controller.dart';

class CaptureImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CaptureImageController());
  }
}