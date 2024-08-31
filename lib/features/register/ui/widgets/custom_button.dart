import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/core/theming/app_colors.dart';
import 'package:chat_app/core/theming/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color color;
  final double width;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.color, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,  // Ensures the button takes full width
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
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
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
                color: color,
              ),
            ),
            SizedBox(width: 8.w),  // Space between text and icon
            Icon(
              Icons.arrow_forward,
              color: color,
              size: 24,  // Adjusted the size for better proportion
            ),
          ],
        ),
      ),
    );
  }
}
