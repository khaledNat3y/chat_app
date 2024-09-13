import 'package:chat_app/core/theming/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_theme.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.zero,
        ),
      ),
      onPressed: () {},
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: AppTheme.font14BlackRegular,
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, Routes.register);
                },
              text: "Sign up",
              style: AppTheme.font18GreyBold.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
