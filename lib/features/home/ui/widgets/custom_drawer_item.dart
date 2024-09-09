import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:chat_app/features/home/data/models/drawer_item_model.dart';
import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  final DrawerItemModel drawerItemModel;
  const CustomDrawerItem({super.key, required this.drawerItemModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: drawerItemModel.onTap,
      leading: Icon(drawerItemModel.icon, color: drawerItemModel.color ?? AppColors.blue,),
      title: Text(drawerItemModel.title, style: AppTheme.font18BlackRegular,),
    );
  }
}
