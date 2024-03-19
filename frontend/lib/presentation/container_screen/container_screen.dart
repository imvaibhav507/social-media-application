import 'package:vaibhav_s_application2/presentation/home_screen/home_screen.dart';
import 'package:vaibhav_s_application2/presentation/messages_page/messages_page.dart';
import 'package:vaibhav_s_application2/presentation/notifications_page/notifications_page.dart';
import 'package:vaibhav_s_application2/presentation/profile_page/profile_page.dart';
import 'package:vaibhav_s_application2/presentation/search_screen/search_screen.dart';
import 'package:vaibhav_s_application2/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/container_controller.dart';

// ignore_for_file: must_be_immutable
class ContainerScreen extends GetWidget<ContainerController> {
  ContainerScreen({Key? key}) : super(key: key);
  RxString currentRoute = AppRoutes.homeScreen.obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => getCurrentPage(currentRoute.value)),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar() {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        currentRoute.value = getCurrentRoute(type);
        // Get.toNamed(getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeScreen;
      case BottomBarEnum.Search:
        return AppRoutes.searchScreen;
      case BottomBarEnum.Messages:
        return AppRoutes.messagesPage;
      case BottomBarEnum.Notifications:
        return AppRoutes.notificationsPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      default:
        return AppRoutes.homeScreen;
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.messagesPage:
        return MessagesPage();
      case AppRoutes.notificationsPage:
        return NotificationsPage();
      case AppRoutes.searchScreen:
        return SearchScreen();
      case AppRoutes.profilePage:
        return ProfilePage();
      default:
        return HomeScreen();
    }
  }
}
