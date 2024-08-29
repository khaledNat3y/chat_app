import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/core/helper/app_regex.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:chat_app/features/register/ui/widgets/custom_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const RegisterForm({super.key, required this.formKey});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  bool isObscureText = true;
  late String firstName;
  late String lastName;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Form(
      key: widget.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(height * 0.23),
              CustomTextFormField(
                hintText: "First name",
                onChanged: (text) {
                  firstName = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
              CustomTextFormField(
                hintText: "Last name",
                onChanged: (text) {
                  lastName = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
              CustomTextFormField(
                hintText: "Email",
                onChanged: (text) {
                  email = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter an email';
                  }
                  final emailRegex = AppRegex.isEmailValid(email);
                  if (!emailRegex) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              verticalSpace(height * 0.06),
              CustomTextFormField(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                hintText: "Password",
                obscureText: isObscureText,
                onChanged: (text) {
                  password = text;
                },
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Please enter a password';
                  }
                  // final passwordRegex = AppRegex.isPasswordValid(password);
                  // if (!passwordRegex) {
                  //   return 'Password must be at least 8 characters long and contain at least one uppercase letter';
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
