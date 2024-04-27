import 'package:flutter/widgets.dart';
import 'package:vaibhav_s_application2/presentation/notifications_page/models/recent_follow_request_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';

import '../../../core/app_export.dart';
import '../models/notifications_model.dart';

/// A controller class for the NotificationsPage.
///
/// This class manages the state of the NotificationsPage, including the
/// current notificationsModelObj
class NotificationsController extends GetxController {
  NotificationsController(this.notificationsModelObj, this.recentFollowRequestModelObj);

  Rx<NotificationsModel> notificationsModelObj;

  Rx<RecentFollowRequestModel> recentFollowRequestModelObj;
  Key? key;
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getRecentFollowRequest();
  }

  AuthRepository authRepository = AuthRepository();

  Future<void> getRecentFollowRequest() async {
    await authRepository.getRecentFollowRequest().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      print(data);
      recentFollowRequestModelObj.value = new RecentFollowRequestModel.fromJson(data);
      update([[key], true]);
    });
  }
}
