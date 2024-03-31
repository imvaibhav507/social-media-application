import 'package:vaibhav_s_application2/presentation/add_member_screen/controller/add_members_controller.dart';
import 'package:vaibhav_s_application2/presentation/add_member_screen/models/search_users_model.dart';

import '../../../core/app_export.dart';

class AddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMemberController(SearchUsersModel().obs)
    );
  }
}