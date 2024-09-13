import 'package:chat_app/core/constants/app_assets.dart';
import 'package:chat_app/core/helper/extensions.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:chat_app/features/register/logic/register_cubit.dart';
import 'package:chat_app/features/register/ui/widgets/custom_button.dart';
import 'package:chat_app/features/register/ui/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      listener: (context, state) async {
        if (state is RegisterSuccess) {
          EasyLoading.dismiss();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Success Register"),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Routes.login);
                    },
                    child: Text("Login", style: AppTheme.font13BlackRegular),
                  ),
                ],
              );
            },
          );
        } else if (state is RegisterError) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.red,
            ),
          );
        } else {
          EasyLoading.show(status: "Loading...");
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
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
              ),
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
                    width: double.infinity,
                    onPressed: () {
                      validateForm();
                    },
                    text: "Create Account",
                    backgroundColor: AppColors.white,
                    color: AppColors.black.withOpacity(0.5),
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
