import 'package:flutter/material.dart';

import '../../../../core/theming/app_theme.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.zero,
        ),
      ),
      onPressed: () {},
      child: Text(
        "Forgot Password?",
        style: AppTheme.font14BlackRegular,
      ),
    );
  }
}
