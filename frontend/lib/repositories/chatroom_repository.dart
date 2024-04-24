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
  Future<dynamic> getPersonalChatDetails(String id) async {
    dynamic response = await _apiServices.getApi(AppUrl.getPersonalChatDetails + '?id=${id}');
    return response;
  }

  Future<dynamic> createPersonalChat(String id) async {
    dynamic response = await _apiServices.getApi(AppUrl.createPersonalChat + '?participantUserId=${id}');
    return response;
  }

  Future<dynamic> renameChatroom(String id, String name) async {
    dynamic response = await _apiServices.patchApi(AppUrl.renameChatroom + '?id=${id}&name=${name}', {});
    return response;
  }

  Future<dynamic> deleteChatroom(String id) async {
    dynamic response = await _apiServices.deleteApi(AppUrl.deleteChatroom + '?id=${id}', {});
    return response;
  }

  Future<dynamic> leaveChatroom(String id) async {
    dynamic response = await _apiServices.getApi(AppUrl.leaveChatroom + '?id=${id}');
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
  
  Future<dynamic> getSearchedUsers(String chatroomId, String key) async {
    dynamic response = await _apiServices.getApi(AppUrl.getSearchedUsersApi + '?chatroomId=${chatroomId}&searchQuery=${key}');
    return response;
  }

  Future<dynamic> addMembersToChatroom(var data) async {
    dynamic response = await _apiServices.patchApi(AppUrl.addMembersToChatroomApi, data);
    return response;
  }

  Future<dynamic> getSingleChatroomListItem(String chatroomId) async {
    dynamic response = await _apiServices.getApi(AppUrl.getSingleChatroomListItemApi + '?chatroomId=${chatroomId}');
    return response;
  }
}