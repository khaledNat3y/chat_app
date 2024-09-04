import 'package:flutter/material.dart';

import '../../../../core/helper/shared_preferences.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/app_theme.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    String firstName = SharedPreferencesHelper.getData(key: "FirstName") ?? "";
    return DrawerHeader(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Chat App",
            style: AppTheme.font24BlueBold,
          ),
          verticalSpace(
            10,
          ),
          RichText(
            text: TextSpan(
                text: "Welcome ",
                style: AppTheme.font20BlackMedium,
                children: [
                  TextSpan(text: firstName, style: AppTheme.font20BlueMedium),
                ]),
          ),
        ],
      ),
    );
  }
}