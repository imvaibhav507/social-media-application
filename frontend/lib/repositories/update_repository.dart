import 'package:vaibhav_s_application2/data/network/network_api_services.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

class UpdateRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> addGender(var data) async{
    dynamic response = await _apiServices.patchApi(AppUrl.addGenderApi, data);
    return response;
  }
}