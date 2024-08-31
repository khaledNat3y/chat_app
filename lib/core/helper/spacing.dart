import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox verticalSpace(double height) => SizedBox(height: height.h,);

SizedBox horizontalSpace(double width) => SizedBox(width: width.w,);

double screenHeight(BuildContext context,double dividedBy) => MediaQuery.of(context).size.height * dividedBy;

double screenWidth(BuildContext context,double dividedBy) => MediaQuery.of(context).size.height * dividedBy;
