import 'package:chat_app/features/home/data/models/drawer_item_model.dart';
import 'package:flutter/material.dart';

import 'custom_drawer_item.dart';

class CustomDrawerItemsListView extends StatelessWidget {
  final List<DrawerItemModel> drawerItems;
  const CustomDrawerItemsListView({super.key, required this.drawerItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: drawerItems.length,
      itemBuilder: (context, index) {
        return CustomDrawerItem(drawerItemModel: drawerItems[index],);
      },
    );
  }
}