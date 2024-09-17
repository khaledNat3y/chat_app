import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:chat_app/features/login/logic/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theming/app_colors.dart';

class LoginWithGoogleWidget extends StatelessWidget {
  const LoginWithGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await context.read<LoginCubit>().signInWithGoogle();
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: MediaQuery.sizeOf(context).width * 0.13,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              AppAssets.google,
              width: MediaQuery.sizeOf(context).width * 0.1,
              height: MediaQuery.sizeOf(context).width * 0.1,
            ),
            Text(
              AppLocalizations.of(context)!.sign_in_with_Google,
              style: AppTheme.font14BlackRegular,
            ),
          ],
        ),
      ),
    );
  }
}
