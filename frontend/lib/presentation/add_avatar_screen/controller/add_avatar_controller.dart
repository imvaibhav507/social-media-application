import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaibhav_s_application2/core/utils/file_upload_helper_2.dart';
import 'package:vaibhav_s_application2/repositories/update_repository.dart';
import 'package:vaibhav_s_application2/repositories/upload_repository.dart';
import '../../../core/app_export.dart';

class AddAvatarController extends GetxController{


  Rx<List<String>> radioList = Rx(["female", "male"]);

  Rx<String> genderRadioGroup = "female".obs;
  
  UploadRepository _uploadRepository = UploadRepository();
  UpdateRepository _updateRepository = UpdateRepository();
  
  RxBool loading = false.obs;

  RxBool isUpdated = false.obs;

  RxString imgUrl = "".obs;

  void setLoading(value) {
    loading.value = value;
  }

  Future<void> uploadAvatar(BuildContext context) async {
    setLoading(true);
    // In your button's onPressed handler or other suitable place:

    FileManagerTwo().showModelSheetForImage(
      context: context,
      maxFileSize: 15 * 1024 * 1024, // 5 MB maximum
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      getFiles: (List<XFile?> files) async {
        // Handle the selected images here
        var imageFile = files[0];
        try {
          // Use a function like uploadImageApi to send the image (replace with your actual logic)
          await _uploadRepository.uploadImageApi(imageFile)
              .then((value) {
                setLoading(false);
                final response = ApiResponse.completed(value).data as Map<String,dynamic>;
                imgUrl.value = response['data'];
                print(response['data']);
          });
          // Handle response
        } catch (error) {
          // Handle upload errors
          print(error.toString());
        }
      },
    );

  }

  Future<void> updateGender(var data) async {
    try{
      await _updateRepository.addGender(data)
          .then((value) {
            final response = ApiResponse.completed(value).data as Map<String,dynamic>;
            if(response['statusCode']==200) {
              isUpdated.value = true;
            }
      });
    } catch(error) {
      print(error.toString());
    }
  }
}