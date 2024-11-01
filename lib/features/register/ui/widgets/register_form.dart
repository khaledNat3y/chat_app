import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/core/helper/app_regex.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/features/register/ui/widgets/custom_text_form_field.dart';
import '../../logic/register_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: context.read<RegisterCubit>().formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(height * 0.23),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.first_name,
                onChanged: (text){
                  context.read<RegisterCubit>().firstName = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_first_name;
                  }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.last_name,
                onChanged: (text) {
                  context.read<RegisterCubit>().lastName = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_last_name;
                  }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.email,
                onChanged: (text) {
                  context.read<RegisterCubit>().email = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_email;
                  }
                  final emailRegex = AppRegex.isEmailValid(text);
                  if (!emailRegex) {
                    return AppLocalizations.of(context)!.invalid_email;
                  }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
              CustomTextFormField(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      context.read<RegisterCubit>().isObscureText =
                      !context.read<RegisterCubit>().isObscureText;
                    });
                  },
                  child: Icon(
                    context.read<RegisterCubit>().isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                hintText: AppLocalizations.of(context)!.password,
                obscureText: context.read<RegisterCubit>().isObscureText,
                onChanged: (text) {
                  context.read<RegisterCubit>().password = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.please_enter_password;
                  }
                  // final passwordRegex = AppRegex.isPasswordValid(text);
                  // if (!passwordRegex) {
                  //   return 'Invalid Password';
                  // }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
            ],
          ),
        ),
      ),
    );
  }
}
