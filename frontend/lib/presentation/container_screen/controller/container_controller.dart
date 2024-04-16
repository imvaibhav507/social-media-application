import 'package:flutter/material.dart';
import '../models/container_model.dart';
import '../../../core/app_export.dart';
class ContainerController extends GetxController with GetSingleTickerProviderStateMixin {

  TextEditingController searchController = TextEditingController();

  Rx<ContainerModel> containerModelObj =
      ContainerModel().obs;

  late TabController tabviewController =
  Get.put(TabController(vsync: this, length: 2));
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}