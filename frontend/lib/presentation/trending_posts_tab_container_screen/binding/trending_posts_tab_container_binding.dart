import 'package:vaibhav_s_application2/presentation/trending_posts_tab_container_screen/controller/trending_posts_tab_container_controller.dart';
import 'package:get/get.dart';

/// A binding class for the TrendingPostsTabContainerScreen.
///
/// This class ensures that the TrendingPostsTabContainerController is created when the
/// TrendingPostsTabContainerScreen is first loaded.
class TrendingPostsTabContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrendingPostsTabContainerController());
  }
}
