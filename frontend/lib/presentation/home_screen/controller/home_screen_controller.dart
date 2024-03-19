import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/home_screen_model.dart';

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  TextEditingController searchController = TextEditingController();

  Rx<HomeScreenModel> homeScreenModelObj =
      HomeScreenModel().obs;

  late TabController tabviewController =
  Get.put(TabController(vsync: this, length: 4));

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
