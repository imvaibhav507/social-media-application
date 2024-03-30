import 'package:vaibhav_s_application2/res/app_url/app_url.dart';

import '../data/network/network_api_services.dart';

class ChatroomRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> getChatroomList() async{
    dynamic response = await _apiServices.getApi(AppUrl.getChatroomListApi);
    return response;
  }

  Future<dynamic> getChatroomDetails(String id) async {
    dynamic response = await _apiServices.getApi(AppUrl.getChatroomDetails + '?id=${id}');
    return response;
  }

  Future<dynamic> getMessagesList(String id, int page, int limit) async{
    dynamic response = await _apiServices.getApi(AppUrl.getMessagesListApi + '?id=${id}&page=${page}&limit=${limit}');
    return response;
  }

  Future<dynamic> sendMessage(var data) async {
    dynamic response = await _apiServices.postApi(AppUrl.sendMessageApi, data);
    return response;
  }
  
  Future<dynamic> getSearchResults(String key) async {
    dynamic response = await _apiServices.getApi(AppUrl.getSearchResultApi + '?search=${key}');
    return response;
  }
}