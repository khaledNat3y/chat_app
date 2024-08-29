import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text,});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 16.h),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(AppColors.white),
                elevation: WidgetStateProperty.all<double>(5),
                shadowColor: WidgetStateProperty.all<Color>(
                  Colors.black.withOpacity(0.5),
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    text,
                    style: AppTheme.font18GreyBold.copyWith(
                      color: AppColors.grey.withOpacity(0.5),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.grey.withOpacity(0.5),
                    size: 34,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
