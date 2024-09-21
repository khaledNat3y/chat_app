import 'package:chat_app/features/login/logic/login_cubit.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/app_regex.dart';
import '../../../../core/helper/shared_preferences.dart';
import '../../../../core/helper/spacing.dart';
import '../../../register/ui/widgets/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          verticalSpace(screenHeight(context, 0.06)),
          CustomTextFormField(
            hintText: S.of(context).email,
            onChanged: (text) {
              context.read<LoginCubit>().email = text;
              _storeUserName(text);
            },
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return S.of(context).please_enter_email;
              }
              final emailRegex = AppRegex.isEmailValid(text);
              if (!emailRegex) {
                return S.of(context).invalid_email;
              }
              return null;
            },
          ),
          verticalSpace(screenHeight(context, 0.06)),
          CustomTextFormField(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  context.read<LoginCubit>().isObscureText = !context.read<LoginCubit>().isObscureText;
                });
              },
              child: Icon(
                context.read<LoginCubit>().isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            hintText: S.of(context).password,
            obscureText: context.read<LoginCubit>().isObscureText,
            onChanged: (text) {
              context.read<LoginCubit>().password = text;
            },
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return S.of(context).please_enter_password;
              }
              // final passwordRegex = AppRegex.isPasswordValid(text);
              // if (!passwordRegex) {
              //   return 'Password must be at least 8 characters long and contain at least one uppercase letter';
              // }
              return null;
            },
          ),
        ],
      ),
    );
  }
  // Extract first word from email and store in SharedPreferences
  void _storeUserName(String email) {
    if (email.contains('@')) {
      String firstName = email.split('@')[0];
      firstName = firstName.replaceAll(RegExp(r'[0-9]'), '');
      SharedPreferencesHelper.setData(key: 'FirstName', value: firstName);
    }
  }
}
