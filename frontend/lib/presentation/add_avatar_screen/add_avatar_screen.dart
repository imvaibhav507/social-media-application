import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/add_avatar_screen/controller/add_avatar_controller.dart';
import 'package:vaibhav_s_application2/presentation/add_avatar_screen/models/add_gender_model.dart';
import 'package:vaibhav_s_application2/widgets/custom_elevated_button.dart';
import 'package:vaibhav_s_application2/widgets/custom_radio_button.dart';

class AddAvatarScreen extends GetWidget<AddAvatarController> {
  AddAvatarScreen({Key? key}) : super(key: key);

  AddAvatarController controller = Get.find<AddAvatarController>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.deepPurpleA200,
        // appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 37.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Almost there !",
                  style: CustomTextStyles.headlineLargePrimary,
                ),
                SizedBox(height: 20.v),
                SizedBox(height: 50.v),
                _buildAvatarPlaceholder(context),
                SizedBox(height: 20.v),
                Text(
                  "Add an avatar",
                  style: CustomTextStyles.titleLargeGray200,
                ),
                SizedBox(height: 60.v),
                Text(
                  "Please specify your gender",
                  style: CustomTextStyles.titleLargeGray200,
                ),
                SizedBox(height: 50.v),
                _buildGenderRadioGroup(),
                SizedBox(height: 100.v),
                _buildDoneButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder(BuildContext context) {
    return Obx(
      () => Stack(children: [

        (controller.imgUrl.value != "")?
        Container(
          height: 150.h,
          width: 150.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white, width: 3)
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child:
          (controller.loading.value == true)? CircularProgressIndicator():
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: GestureDetector(
              onTap: () {
                onTapUploadImage(context);
              },
              child: Image.network(
                controller.imgUrl.value,
                fit: BoxFit.cover, // Adjust as needed
              ),
            ),
          ),
        ):
        CustomImageView(
          height: 150.v,
          width: 150.h,
          imagePath:ImageConstant.imgUserProfile,
          radius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white),
          onTap: () {
            onTapUploadImage(context);
          },
        ),
        Positioned(
            bottom: 0.h,
            right: 5.h,
            child: Container(
              padding: EdgeInsets.all(5.adaptSize),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                border: Border.all(
                  color: appTheme.deepPurpleA200,
                  width: 5.h,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CustomImageView(
                  fit: BoxFit.fitWidth,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  imagePath: ImageConstant.imgEdit2,
                  color: appTheme.deepPurpleA200,
                ),
              ),
            )),
      ]),
    );
  }

  Widget _buildGenderRadioGroup() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomRadioButton(
            text: "lbl_female".tr,
            value: controller.radioList.value[0],
            groupValue: controller.genderRadioGroup.value,
            padding: EdgeInsets.fromLTRB(8.h, 14.v, 30.h, 14.v),
            onChange: (value) {
              controller.genderRadioGroup.value = value;
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: CustomRadioButton(
              text: "lbl_male".tr,
              value: controller.radioList.value[1],
              groupValue: controller.genderRadioGroup.value,
              padding: EdgeInsets.fromLTRB(8.h, 14.v, 30.h, 14.v),
              onChange: (value) {
                controller.genderRadioGroup.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneButton() {
    return CustomElevatedButton(
        text: "Done".tr,
        buttonStyle: CustomButtonStyles.fillPrimary,
        onPressed: () {
          onTapUpdateGender();
          if(controller.isUpdated.value) {
            Get.offNamed(AppRoutes.containerScreen);
          }
        },
    );
  }

  void onTapUploadImage(BuildContext context) async{
    await controller.uploadAvatar(context);
  }

  void onTapUpdateGender() async {
    AddGenderModel addGenderModel = AddGenderModel(
      gender: controller.genderRadioGroup.value,
    );
    await controller.updateGender(addGenderModel.toJson());

  }
}
