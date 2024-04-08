import 'package:vaibhav_s_application2/data/network/network_api_services.dart';
import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

class PostsRepository{
  final _apiServices = NetworkApiServices();
  
  Future<dynamic> getAllPosts() async{
    dynamic response = await _apiServices.getApi(AppUrl.getAllPostsApi);
    return response;
  }
}