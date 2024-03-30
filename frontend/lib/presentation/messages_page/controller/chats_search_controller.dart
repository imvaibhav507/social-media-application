import 'package:vaibhav_s_application2/presentation/messages_page/models/messages_model.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/models/search_chatroom_model.dart';
import 'package:vaibhav_s_application2/repositories/chatroom_repository.dart';

import '../../../core/app_export.dart';
import 'package:flutter/material.dart';

/// A controller class for the SearchScreen.
///
/// This class manages the state of the SearchScreen, including the
/// current searchModelObj
class SearchChatroomsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final ChatroomRepository chatroomRepository = ChatroomRepository();

  Rx<SearchChatroomModel> searchChatroomModelObj = SearchChatroomModel().obs;

  get isLoading => _isLoading;

  bool _isLoading = false;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  Future<void> getSearchResults(String key) async {
    _isLoading = true;
    await chatroomRepository.getSearchResults(key)
        .then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      searchChatroomModelObj.value = new SearchChatroomModel.fromJson(data);
      _isLoading = false;
    }).onError((error, stackTrace) {print(error.toString());});
  }
}
