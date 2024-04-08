import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/core/utils/file_upload_helper_2.dart';
import 'package:vaibhav_s_application2/presentation/create_post_page/models/create_post_model.dart';

class CreatePostController extends GetxController {

  Rx<CreatePostModel> createPostModelObj = CreatePostModel().obs;

  TextEditingController captionsController = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    openImagePicker();
  }

  void openImagePicker() {
    FileManagerTwo().showModelSheetForImage(
      context: Get.context!,
      maxFileSize: 15 * 1024 * 1024, // 5 MB maximum
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      isMultiImage: true,
      getFiles: (List<XFile?> files) async {
        // Handle the selected images here
        createPostModelObj.value.files?.addAll(files);
      },
    );
  }


}