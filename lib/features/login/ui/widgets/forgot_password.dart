import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        AppLocalizations.of(context)!.forgot_password,
        style: AppTheme.font14BlackRegular,
      ),
    );
  }
}
