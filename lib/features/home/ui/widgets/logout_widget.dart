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
      onPressed: () {
        // Perform the navigation before the async operations
        final navigator = Navigator.of(context);

        // Execute async operations after storing the navigator
        _logout(navigator, context);
      },
    );
  }

  Future<void> _logout(NavigatorState navigator, BuildContext context) async {

  }
}
