import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/features/login/ui/widgets/dont_have_account.dart';
import 'package:chat_app/features/login/ui/widgets/forgot_password.dart';
import 'package:chat_app/features/login/ui/widgets/login_form.dart';
import 'package:chat_app/features/login/ui/widgets/login_with_google_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/app_theme.dart';
import '../../register/ui/widgets/custom_button.dart';
import '../logic/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              EasyLoading.show(status: AppLocalizations.of(context)!.loading);
            } else if (state is LoginFailure) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.red,
                ),
              );
            } else if (state is LoginSuccess) {
              EasyLoading.dismiss();
              context.pushReplacementNamed(Routes.home);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // leading: IconButton(onPressed: (){
              //   context.pop();
              // }, icon: const Icon(Icons.arrow_back)),
              backgroundColor: Colors.transparent,
              title: Text(
                AppLocalizations.of(context)!.login,
                style: AppTheme.font24WhiteBold,
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.12,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(screenHeight(context, 0.15)),
                    const LoginForm(),
                    verticalSpace(screenHeight(context, 0.01)),
                    const ForgotPassword(),
                    verticalSpace(screenHeight(context, 0.05)),
                    CustomButton(
                      width: double.infinity,
                      onPressed: () {
                        validateForm();
                      },
                      text: AppLocalizations.of(context)!.login,
                      color: AppColors.white,
                      backgroundColor: AppColors.blue,
                    ),
                    verticalSpace(screenHeight(context, 0.05)),
                    const Center(
                      child: LoginWithGoogleWidget(),
                    ),
                    verticalSpace(screenHeight(context, 0.05)),
                    const Center(
                      child: DontHaveAccount(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void validateForm() {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().loginWithFirebase();
    }
  }

}
