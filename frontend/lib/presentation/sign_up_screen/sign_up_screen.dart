import 'package:vaibhav_s_application2/data/models/sign_up_model.dart';
import 'package:vaibhav_s_application2/presentation/log_in_screen/models/log_in_model.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:vaibhav_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:vaibhav_s_application2/core/utils/validation_functions.dart';
import 'package:vaibhav_s_application2/widgets/custom_text_form_field.dart';
import 'package:vaibhav_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'controller/sign_up_controller.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends GetWidget<SignUpController> {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  SignUpController controller = Get.find<SignUpController>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.deepPurpleA200,
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 37.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "msg_create_a_new_account".tr,
                      style: CustomTextStyles.headlineLargePrimary,
                    ),
                    SizedBox(height: 10.v),
                    Text(
                      "msg_it_s_fast_and_easy".tr,
                      style: CustomTextStyles.bodyLargePrimary,
                    ),
                    SizedBox(height: 21.v),
                    _buildFirstNameColumn(),
                    SizedBox(height: 16.v),
                    _buildEmail(),
                    SizedBox(height: 16.v),
                    _buildPhone(),
                    SizedBox(height: 16.v),
                    _buildPassword(),
                    SizedBox(height: 16.v),
                    _buildDateOfBirth(context),
                    SizedBox(height: 26.v),
                    Text(
                      "lbl_gender".tr,
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: 42.v),
                    Container(
                      width: 367.h,
                      margin: EdgeInsets.only(
                        left: 8.h,
                        right: 5.h,
                      ),
                      child: Text(
                        "msg_by_clicking_register".tr,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.v),
                    _buildSignUpButton(),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 47.v,
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        onTap: ()=>Get.back(),
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.fromLTRB(26.h, 10.v, 364.h, 10.v),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFirstNameRow() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: CustomTextFormField(
          controller: controller.firstNameRowController,
          hintText: "lbl_first_name".tr,
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLastNameRow() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8.h),
        child: CustomTextFormField(
          controller: controller.lastNameRowController,
          hintText: "lbl_last_name".tr,
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr;
            }
            return null;
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFirstNameColumn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFirstNameRow(),
        _buildLastNameRow(),
      ],
    );
  }

  /// Section Widget
  Widget _buildEmail() {
    return CustomTextFormField(
      controller: controller.emailController,
      hintText: "lbl_email_id".tr,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || (!isValidEmail(value, isRequired: true))) {
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
    );
  }

  Widget _buildPassword() {
    return CustomTextFormField(
      controller: controller.passwordController,
      hintText: "password".tr,
      textInputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || (!isValidEmail(value, isRequired: true))) {
          return "err_msg_please_enter_valid_email".tr;
        }
        return null;
      },
    );
  }

  /// Section Widget
  Widget _buildPhone() {
    return CustomTextFormField(
      controller: controller.usernameController,
      hintText: "Username".tr,
      textInputType: TextInputType.text,
    );
  }

  /// Section Widget
  Widget _buildDateOfBirth(BuildContext context){
    return CustomTextFormField(
      controller: controller.dateOfBirthController,
      hintText: "lbl_date_of_birth".tr,
      textInputAction: TextInputAction.done,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 13.v, 16.h, 13.v),
        child: CustomImageView(
          onTap:() => _selectDate(context),
          imagePath: ImageConstant.imgCalendartoday,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 50.v,
      ),
      contentPadding: EdgeInsets.only(
        left: 16.h,
        top: 15.v,
        bottom: 15.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildSignUpButton() {
    return Obx(
        ()=> CustomElevatedButton(
          onPressed: () {
             onPressUserSignup();
            },
          text: (controller.loading.value)? "Loading...":"lbl_sign_up".tr,
          buttonStyle: CustomButtonStyles.fillPrimary,
        ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent)
              ), child: child!);
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(1900,1),
        lastDate: DateTime.now(),
        confirmText: 'Confirm',
        cancelText: 'Cancel',

    );

    final date = pickedDate?.format();
    print(date);
    if(date!=null) {
      controller.dateOfBirthController.text = date;
    }
  }

  void onPressUserSignup() async{


    final name = '${controller.firstNameRowController.value.text} ${controller.lastNameRowController.value.text}';
    final email = controller.emailController.value.text;
    final username = controller.usernameController.value.text;
    final dob = controller.emailController.value.text;
    final password = controller.passwordController.value.text;

    SignUpModel user = SignUpModel(
      fullName: name,
      email: email,
      username: username,
      password: password,
      dateOfBirth: dob,
    );
    await controller.userSignup(user.toJson());

    LoginModel loginModel = LoginModel(
      email: email,
      password: password
    );
    await controller.userLogin(loginModel.toJson());

  }
}
