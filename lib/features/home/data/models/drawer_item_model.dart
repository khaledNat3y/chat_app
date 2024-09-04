import 'package:flutter/material.dart';

class DrawerItemModel {
  final String title;
  final IconData icon;
  final Color? color;
  final Function()? onTap;
  DrawerItemModel({required this.title, required this.icon, this.color, this.onTap});

}