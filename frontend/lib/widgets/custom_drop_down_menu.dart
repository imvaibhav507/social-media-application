import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  CustomPopupMenuButton({Key? key})
      : super(
          key: key,
        );

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
                              Icon(item.icon),
                              SizedBox(width: 10),
                              Text(item.text, style: TextStyle(fontSize: 14),),
                            ],
                          )))
                  .toList(),
            ]);
  }

  onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemCreateGroup :

      case MenuItems.itemSettings:
    }
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({required this.text, required this.icon});
}

class MenuItems {

  static const itemCreateGroup = MenuItem(text: 'Create Group', icon: Icons.add);
  static const itemSettings = MenuItem(text: 'Settings', icon: Icons.settings);

  static const List<MenuItem> menuItems = [
    itemCreateGroup,
    itemSettings
  ];
}


