import 'package:chat_app/core/di/dependency_injection.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/home/ui/home.dart';
import 'package:chat_app/features/login/logic/login_cubit.dart';
import 'package:chat_app/features/login/ui/login_screen.dart';
import 'package:chat_app/features/register/ui/register_screen.dart';
import 'package:chat_app/features/settings/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/chat_room/ui/chat_room.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/register/data/register_repository/register_repository.dart';
import '../../features/register/logic/register_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getIt<LoginCubit>(),
                  child: const LoginScreen(),
                ));
      case Routes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => getIt<RegisterCubit>(),
                  child: const RegisterScreen(),
                ));
      case Routes.home:
        return MaterialPageRoute(
            builder: (_) => const Home());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const Settings());
      case Routes.chatRoom:
        return MaterialPageRoute(builder: (_) => const ChatRoom());
      default:
        return MaterialPageRoute(
            builder: (_) => NoDefinedRouteScreen(
                  settings: settings,
                ));
    }
  }
}

class NoDefinedRouteScreen extends StatelessWidget {
  final RouteSettings settings;

  const NoDefinedRouteScreen({
    super.key,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No route defined for ${settings.name}"),
      ),
    );
  }
}
