import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_app.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /// to fix sp issue in release mode.
  ScreenUtil.ensureScreenSize();
  configureDependencies();
  runApp(ChatApp(appRouter: AppRouter(),));
}




