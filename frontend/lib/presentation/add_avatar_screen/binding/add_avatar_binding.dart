import 'package:vaibhav_s_application2/presentation/add_avatar_screen/controller/add_avatar_controller.dart';

import '../../../core/app_export.dart';

class AddAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAvatarController());
  }
}
