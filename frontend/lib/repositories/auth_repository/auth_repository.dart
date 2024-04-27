import 'package:vaibhav_s_application2/data/network/network_api_services.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

class AuthRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> signupApi(var data) async {
    dynamic response = _apiService.postApi(AppUrl.signupApi, data);
    return response;
  }

  Future<dynamic> loginApi(var data) async {
    dynamic response = _apiService.postApi(AppUrl.loginApi, data);
    return response;
  }

  Future<dynamic> loggedInUser() async {
    dynamic response = _apiService.getApi(AppUrl.getLoggedInUserApi);
    return response;
  }

  Future<dynamic> getUserProfile(String userId) async {
    dynamic response = _apiService.getApi(AppUrl.getUserProfileApi + '?userId=${userId}');
    return response;
  }

  Future<dynamic> searchUserProfile(String query) async {
    dynamic response = _apiService.getApi(AppUrl.searchUserProfileApi + '?searchQuery=${query}');
    return response;
  }

  Future<dynamic> sendFollowRequest(String userId) async {
    dynamic response = _apiService.putApi(AppUrl.followRequestApi + '?userId=${userId}', {});
    return response;
  }

  Future<dynamic> approveFollowRequest(String requestId, String res) async {
    dynamic response = _apiService.deleteApi(AppUrl.followRequestApi + '?requestId=${requestId}&response=${res}', {});
    return response;
  }
  Future<dynamic> getFollowRequests() async {
    dynamic response = _apiService.getApi(AppUrl.followRequestApi);
    return response;
  }

  Future<dynamic> getRecentFollowRequest() async {
    dynamic response = _apiService.getApi(AppUrl.getRecentRequestApi);
    return response;
  }

}