import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class BaseApiServices {

  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(String url, var data);
  Future<dynamic> uploadImageApi(String url, List<XFile> imageFile, String filename);
  Future<dynamic> patchApi(String url, var data);
  Future<dynamic> putApi(String url, var data);
}