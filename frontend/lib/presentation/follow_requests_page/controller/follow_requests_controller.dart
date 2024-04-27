import 'package:get/get.dart';
import 'package:vaibhav_s_application2/presentation/follow_requests_page/models/follow_requests_model.dart';
import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';

import '../../../core/app_export.dart';

class FollowRequestsController extends GetxController {

  FollowRequestsController(this.followRequestsModelObj);

  Rx<FollowRequestsModel> followRequestsModelObj;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    setLoading(true);
    await getFollowRequestsList();
  }

  RxBool isLoading = false.obs;

  setLoading(value) {
    isLoading.value = value;
  }

  AuthRepository authRepository = AuthRepository();

  Future<void> getFollowRequestsList() async {
    setLoading(true);
    authRepository.getFollowRequests().then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      followRequestsModelObj.value = FollowRequestsModel.fromJson(data);
      setLoading(false);
    });
    setLoading(false);
  }

  Future<void> approveFollowRequest(String requestId, String response) async {
    authRepository.approveFollowRequest(requestId, response).then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      if(data['statusCode'] == 200) {
        followRequestsModelObj.value.followRequestsList?.removeWhere((item) => item.sId == requestId);
      }
    });
  }
}