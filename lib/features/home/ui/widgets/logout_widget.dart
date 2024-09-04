import 'package:chat_app/core/helper/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/shared_preferences.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.logout,
        color: AppColors.white,
        size: 34,
      ),
      onPressed: () async{
        await SharedPreferencesHelper.clearAllData();
        try {
          await FirebaseAuth.instance.signOut();
          context.pushReplacementNamed(Routes.login);
        }catch(e){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error signing out: $e'),
            backgroundColor: AppColors.red,
          ));
        }
      },
    );
  }
}