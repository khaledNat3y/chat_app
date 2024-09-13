import 'package:chat_app/features/home/data/models/drawer_item_model.dart';
import 'package:chat_app/features/home/ui/widgets/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theming/app_colors.dart';
import 'custom_drawer_header.dart';
import 'custom_drawer_items_list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  static List<DrawerItemModel> drawerItems = [
    DrawerItemModel(
      title: "S e t t i n g s",
      icon: FontAwesomeIcons.gear,
      color: AppColors.blue,
      onTap: () {},
    ),
    DrawerItemModel(
      title: "L o g o u t",
      icon: FontAwesomeIcons.arrowRightFromBracket,
      onTap: () {
        const LogoutWidget();
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomDrawerHeader(),
          CustomDrawerItemsListView(
            drawerItems: drawerItems,
          ),
        ],
      ),
    );
  }
}


