import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/core/utils/file_upload_helper_2.dart';
import 'package:vaibhav_s_application2/presentation/create_post_page/models/create_post_model.dart';
import 'package:vaibhav_s_application2/repositories/posts_repository.dart';
import 'package:vaibhav_s_application2/widgets/custom_snackbar.dart';

class CreatePostController extends GetxController {

  Rx<CreatePostModel> createPostModelObj = CreatePostModel().obs;

  TextEditingController captionsController = TextEditingController();

  PostsRepository postsRepository = PostsRepository();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    openImagePicker();
  }

  RxBool isLoading = false.obs;

  setLoading(value) {
    isLoading.value = value;
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

  Future<void> createPost() async {
    setLoading(true);
    String caption = captionsController.value.text.trim();
    if(caption.isEmpty) {
      setLoading(false);
      CustomSnackBar().showSnackBar(text: 'Caption is required !');
    }
    List<XFile> tobeUploadedFiles = [];
    createPostModelObj.value
        .files?.forEach((file) {if(file !=null) tobeUploadedFiles.add(file);});
    await postsRepository.createPost(tobeUploadedFiles, "attachments", caption).then((value) async{
      final response = await ApiResponse.completed(value);
      print(response.data);
      final data = response.data as Map<String, dynamic>;

      if(data['statusCode'] == 200) {
        setLoading(false);
      }
    });
    setLoading(false);
  }


}