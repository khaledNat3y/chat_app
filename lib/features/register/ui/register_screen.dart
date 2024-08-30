import 'package:chat_app/core/constants/app_assets.dart';
import 'package:chat_app/core/di/dependency_injection.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:chat_app/features/register/logic/register_cubit.dart';
import 'package:chat_app/features/register/ui/widgets/custom_button.dart';
import 'package:chat_app/features/register/ui/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Success Register"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.login, (route) => false);
                      },
                      child: Text("Login", style: AppTheme.font13BlackRegular))
                ],
                  ));
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        } else {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      child: Stack(
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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Create Account",
                style: AppTheme.font24WhiteBold,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const RegisterForm(),
                  CustomButton(
                    onPressed: () {
                      validateForm();
                    },
                    text: "Create Account",
                  ),
                  verticalSpace(height * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
      context.read<RegisterCubit>().registerWithFirebase();
    }
  }
}
