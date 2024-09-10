import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_theme.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final DateTime currentTime;
  final String imagePath;
  final Function()? onTap;
  const CustomCardWidget({super.key, required this.title, required this.description, required this.currentTime, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("yyyy-MM-dd").format(currentTime); // Display current time
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8.r),
        elevation: 10,
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 120.w,
              height: 115.h,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            verticalSpace(10),
            // Text below the image
            Text(
              title,
              style: AppTheme.font14BlackRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpace(5),
            // Add dynamically generated time below the title
            Text(
              formattedDate,
              style: AppTheme.font18BlackRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}