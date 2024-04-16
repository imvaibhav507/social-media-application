import 'package:vaibhav_s_application2/data/network/network_api_services.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

class UploadRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> uploadImageApi(imageFiles, filename) async{
    dynamic response = await _apiService.uploadImageApi(AppUrl.uploadImageApi, imageFiles, filename);
    return response;
  }
}