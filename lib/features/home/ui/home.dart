import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/core/helper/shared_preferences.dart';
import 'package:chat_app/features/home/ui/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/app_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String firstName = SharedPreferencesHelper.getData(key: 'FirstName') ?? '';
    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Positioned.fill(
          child: Image.asset(
            AppAssets.background,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppColors.white,
                size: 34,
              ),
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
            ),
            title: Text(
              'Chat App',
              style: AppTheme.font24WhiteBold,
            ),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppColors.white,size: 34,))
            ],
          ),
          body: Center(),
        ),
      ],
    );
  }
}
