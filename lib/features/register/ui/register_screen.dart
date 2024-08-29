import 'package:chat_app/core/constants/app_assets.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';
import 'package:chat_app/features/register/ui/widgets/custom_button.dart';
import 'package:chat_app/features/register/ui/widgets/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                RegisterForm(formKey: formKey,),
                CustomButton(onPressed: (){
                  validateForm();
                },
                text: "Create Account",),
                verticalSpace(height * 0.05),
              ],
            ),
          ),
        )
      ],
    );
  }

  void validateForm() {
    if(formKey.currentState!.validate()){
      return;
    }
  }
}
