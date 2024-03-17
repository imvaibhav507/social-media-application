import 'package:vaibhav_s_application2/data/network/network_api_services.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

class UploadRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> uploadImageApi(imageFile) async{
    dynamic response = await _apiService.uploadImageApi(AppUrl.uploadImageApi, imageFile);
    return response;
  }
}