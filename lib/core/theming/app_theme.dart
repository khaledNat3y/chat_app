// fontSize: 24.sp,
// fontWeight: FontWeight.w700,
// color: AppColors.black,
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'font_weight_helper.dart';


abstract class AppTheme {
  static TextStyle font24BlackBold = TextStyle(
      fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black
  );

  static TextStyle font24WhiteBold = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.white
  );

  static TextStyle font13BlackRegular = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeightHelper.regular,
      color: AppColors.black,
  );


  static TextStyle font18GreyBold = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.bold,
      color: AppColors.grey,
  );
  ///normal == regular
  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.grey,
  );

  static TextStyle font13GreyRegular = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.grey,
  );

  static TextStyle font14LightGreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.lightGrey,
  );

  static TextStyle font16WhiteMedium = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white,
  );

  static TextStyle font14BlackRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black,
  );

}