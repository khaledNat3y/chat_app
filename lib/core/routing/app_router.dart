import 'package:chat_app/core/di/dependency_injection.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/login/ui/login_screen.dart';
import 'package:chat_app/features/register/ui/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/register/data/register_repository/register_repository.dart';
import '../../features/register/logic/register_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (_) => getIt<RegisterCubit>(),
          child: const RegisterScreen(),
        ));
      default:
        return MaterialPageRoute(builder: (_) => NoDefinedRouteScreen(settings: settings,));
    }
  }
}

class NoDefinedRouteScreen extends StatelessWidget {
  final RouteSettings settings;
  const NoDefinedRouteScreen({
    super.key, required this.settings,
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
