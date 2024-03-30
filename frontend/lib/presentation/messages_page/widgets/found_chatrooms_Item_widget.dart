import 'package:vaibhav_s_application2/presentation/messages_page/models/search_chatroom_model.dart';
import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

// ignore: must_be_immutable
class FoundChatroomItemWidget extends StatelessWidget {

  FoundChatroomItemWidget(
      this.foundChatroomItemObj, {
        Key? key,
      }) : super(
    key: key,
  );

  FoundChatroom foundChatroomItemObj;
  List<Member> members = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 26.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 54.v,
            width: 52.h,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse22,
                  height: 54.v,
                  width: 52.h,
                  radius: BorderRadius.circular(
                    27.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 13.adaptSize,
                    width: 13.adaptSize,
                    decoration: BoxDecoration(
                      color: appTheme.green600,
                      borderRadius: BorderRadius.circular(
                        6.h,
                      ),
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2.h,
                      ),
                    ),
                  ),
                ),
              ],
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
                Obx(
                      () => Text(
                    foundChatroomItemObj.name!.value,
                    style: CustomTextStyles.titleMediumBlack90001,
                  ),
                ),
                SizedBox(height: 8.v),
                      Container(
                        height: 35.v,
                        child: Row(

                          children: [
                            (foundChatroomItemObj.isGroupChat?.value==true)?
                            Text("Members:", style: CustomTextStyles.titleMediumGray600,):
                            Container(),
                            _buildUsernames(foundChatroomItemObj.members)
                          ],

                        ),
                      ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildUsernames(RxList<Member>? members) {
    return Container(
      height: 25.v,
      width: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: members!.length,
          itemBuilder: (context, index) {
          final member = foundChatroomItemObj.members![index];
          if(foundChatroomItemObj.isGroupChat!.value==true){
            print(member.fullname);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:  8),
              child: Text('${member.fullname}', style: CustomTextStyles.titleMediumGray600,),
            );
          }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('@${member.username}', style: CustomTextStyles.titleMediumGray600),
            );
          },
          ),
    );
  }
}
