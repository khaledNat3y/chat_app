import 'package:chat_app/core/routing/app_router.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget {
  final AppRouter appRouter;
  const ChatApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatMate',
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: Routes.login,
    );
  }
}