import 'package:vaibhav_s_application2/repositories/auth_repository/auth_repository.dart';

import '../../../core/app_export.dart';
import '../models/search_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the SearchScreen.
///
/// This class manages the state of the SearchScreen, including the
/// current searchModelObj
class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<SearchedUserProfilesModel> searchedUserProfilesModelObj = SearchedUserProfilesModel().obs;

  AuthRepository authRepository = AuthRepository();

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  RxBool isListLoading = false.obs;
  Future<void> getSearchedUserProfiles(String query) async {
    isListLoading.value = true;
    await authRepository.searchUserProfile(query).then((value) async {
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      searchedUserProfilesModelObj.value = SearchedUserProfilesModel.fromJson(data);
      isListLoading.value = false;
    }).onError((error, stackTrace) {
      searchedUserProfilesModelObj.value = SearchedUserProfilesModel();
      isListLoading.value = false;
    });
  }
}
