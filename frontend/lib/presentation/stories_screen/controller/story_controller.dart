import 'package:flutter/cupertino.dart';

import '../../../core/app_export.dart';
import '../models/stories_model.dart';

/// A controller class for the ForYouScreen.
///
/// This class manages the state of the ForYouScreen, including the
/// current forYouModelObj
class StoriesController extends GetxController {
  Rx<StoriesModel> forYouModelObj = StoriesModel().obs;
  TextEditingController commentController = TextEditingController();
}
