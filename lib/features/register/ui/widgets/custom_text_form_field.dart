import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final Widget? suffixIcon;
  const CustomTextFormField({
    super.key, required this.hintText, this.hintStyle, this.validator, this.onChanged, this.obscureText, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.grey,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: hintStyle ?? AppTheme.font13BlackRegular.copyWith(color: AppColors.black.withOpacity(0.5)),
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.blue,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}