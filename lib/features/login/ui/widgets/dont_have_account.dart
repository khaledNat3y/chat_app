import 'package:chat_app/core/theming/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              text: AppLocalizations.of(context)!.dont_have_account,
              style: AppTheme.font14BlackRegular,
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, Routes.register);
                },
              text: AppLocalizations.of(context)!.sign_up,
              style: AppTheme.font18GreyBold.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
