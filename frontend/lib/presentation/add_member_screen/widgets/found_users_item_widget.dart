import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';
import 'package:vaibhav_s_application2/presentation/add_member_screen/controller/add_members_controller.dart';
import 'package:vaibhav_s_application2/presentation/add_member_screen/models/search_users_model.dart';
import 'package:vaibhav_s_application2/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class FoundUsersItemWidget extends StatelessWidget {
  FoundUsersItemWidget(
    this.foundUserObj, {
    Key? key,
  }) : super(
          key: key,
        );
  var controller = Get.find<AddMemberController>();
  User foundUserObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 12.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 54.v,
            width: 52.h,
            child: CustomImageView(
              imagePath: foundUserObj.avatar,
              height: 54.v,
              width: 52.h,
              radius: BorderRadius.circular(
                27.h,
              ),
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.h,
              top: 2.v,
              bottom: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foundUserObj.fullName!,
                  style: CustomTextStyles.titleMediumBlack90001,
                ),
                SizedBox(height: 8.v),
                Container(
                  height: 35.v,
                  child: Row(
                    children: [_buildUsernames(foundUserObj.username!)],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          (foundUserObj.isAdded!)
              ? CustomIconButton(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(16.h),
                  ),
                  height: 35.v,
                  width: 88.h,
                  padding: EdgeInsets.symmetric(horizontal: 6.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outlined,
                        size: 20.h,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "Added",
                          style: CustomTextStyles.titleSmallPrimary,
                        ),
                      ),
                    ],
                  ),
                ):
          Obx(
            ()=> CustomIconButton(
              height: 35.v,
              width: 88.h,
              decoration: BoxDecoration(
                color: (controller.userModels.contains(foundUserObj))? Colors.grey.shade400: appTheme.deepPurpleA200,
                borderRadius: BorderRadius.circular(16.h),
              ),
              onTap: onTapAddMemberToList,
              child: Center(
                  child: (controller.userModels.contains(foundUserObj))? Icon(Icons.check, color: Colors.white,):Text("Add",
                      style: CustomTextStyles.titleSmallPrimary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsernames(String username) {
    return Container(
      height: 25.v,
      width: 200.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text('@${username}', style: CustomTextStyles.titleMediumGray600),
      ),
    );
  }

  void onTapAddMemberToList() {
    if(controller.userModels.contains(foundUserObj)) {
      print("user already added to list");
      return;
    }
    controller.userModels.add(foundUserObj);
  }
}
