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
}