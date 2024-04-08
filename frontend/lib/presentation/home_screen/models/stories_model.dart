import '../../../core/app_export.dart';
import 'storieslist_item_model.dart';
/// This class defines the variables used in the [stories_page],
/// and is typically used to hold data that is passed between different parts of the application.
class StoriesModel {
  Rx<List<StoriesListItemModel>> storiesListItemList = Rx([
    StoriesListItemModel(
        nineteen: ImageConstant.img19.obs, agnessMonica: "Agness Monica".obs),
    StoriesListItemModel(nineteen: ImageConstant.img19179x147.obs),
    StoriesListItemModel(
        nineteen: ImageConstant.img191.obs, agnessMonica: "Windy Wandah".obs)
  ]);
}
