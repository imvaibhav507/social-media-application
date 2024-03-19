import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/container_screen/controller/container_controller.dart';

class ContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContainerController());
  }
}