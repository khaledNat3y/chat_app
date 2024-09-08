import 'package:chat_app/chat_app.dart';
import 'package:chat_app/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import for formatting date and time

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_theme.dart';

class MyRoomsView extends StatelessWidget {
  const MyRoomsView({super.key});

  @override
  Widget build(BuildContext context) {
    String currentTime = DateFormat('h:mm a').format(DateTime.now()); // Format time to 12-hour format with AM/PM

    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(8.r),
              elevation: 10,
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120.w,
                    height: 120.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)), // Rounded corners for the image
                      child: Image.asset(
                        "assets/images/movies.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  // Text below the image
                  Text(
                    "The Movies Zone",
                    style: AppTheme.font14BlackRegular,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(5),
                  // Add dynamically generated time below the title
                  Text(
                    currentTime, // Display current time
                    style: AppTheme.font18BlackRegular,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
