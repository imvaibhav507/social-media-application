import 'package:image_picker/image_picker.dart';

import '../../../core/app_export.dart';

class CreatePostModel {

  CreatePostModel({this.files}) {
    files = files ?? RxList(<XFile>[]);
  }
  RxList<XFile?>? files;
}