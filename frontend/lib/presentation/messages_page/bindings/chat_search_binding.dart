import 'package:vaibhav_s_application2/presentation/search_screen/controller/search_controller.dart';
import 'package:get/get.dart';

/// A binding class for the SearchScreen.
///
/// This class ensures that the SearchController is created when the
/// SearchScreen is first loaded.
class ChatsSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
