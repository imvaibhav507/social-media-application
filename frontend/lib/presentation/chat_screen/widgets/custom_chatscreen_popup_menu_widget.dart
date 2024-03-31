import 'package:flutter/material.dart';
import 'package:vaibhav_s_application2/core/app_export.dart';

class CustomPopupMenuButton extends StatelessWidget {
  CustomPopupMenuButton({Key? key,
    this.onTapShowGroupInfo,
    this.onTapAddMember,
    this.onTapDeleteGroup,
    this.onTapLeaveGroup,
  })
      : super(
    key: key,
  );

  VoidCallback? onTapShowGroupInfo;
  VoidCallback? onTapDeleteGroup;
  VoidCallback? onTapAddMember;
  VoidCallback? onTapLeaveGroup;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItem>(
        onSelected: (item) => onSelected(context, item),
        itemBuilder: (context) => [
          ...MenuItems.menuItems
              .map(
                  (item) => PopupMenuItem<MenuItem>(
                  value: item,
                  child: Row(
                    children: [
                      item.icon,
                      SizedBox(width: 10),
                      Text(item.text, style: CustomTextStyles.bodyLargeBlack90001,)
                    ],
                  )))
              .toList(),
        ]);
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.leaveGroup :
        onTapLeaveGroup?.call();
        return;
      case MenuItems.deleteGroup:
        onTapDeleteGroup?.call();
        return;
      case MenuItems.groupInfo:
        onTapShowGroupInfo?.call();
        return;
      case MenuItems.addMember:
        onTapAddMember?.call();
        return;
    }
  }
}

class MenuItem {
  final String text;
  final Icon icon;

  const MenuItem({required this.text, required this.icon});
}

class MenuItems {

  static const leaveGroup = MenuItem(text:'Leave group', icon: Icon(Icons.exit_to_app_rounded));
  static const addMember = MenuItem(text:'Add people', icon: Icon(Icons.add_circle_outline_outlined));
  static const deleteGroup = MenuItem(text:'Delete group', icon: Icon( Icons.delete, color: Colors.red,),);
  static const groupInfo = MenuItem(text:'Group info', icon: Icon(Icons.info_outline_rounded),);

  static const List<MenuItem> menuItems = [
    groupInfo,
    addMember,
    leaveGroup,
    deleteGroup
  ];
}


