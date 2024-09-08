import 'package:chat_app/core/routing/app_router.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatApp extends StatelessWidget {
  final AppRouter appRouter;
  const ChatApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      ensureScreenSize: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        title: 'ChatMate',
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}