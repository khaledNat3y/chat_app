import 'package:chat_app/core/di/dependency_injection.dart';
import 'package:chat_app/core/routing/app_router.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/home/logic/home_cubit.dart';
import 'package:chat_app/features/settings/logic/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ChatApp extends StatelessWidget {
  final AppRouter appRouter;

  const ChatApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      ensureScreenSize: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<HomeCubit>()),
          BlocProvider(create: (_) => getIt<SettingsCubit>()),
        ],
        child: BlocBuilder<SettingsCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(),
              title: 'ChatMate',
              onGenerateRoute: appRouter.generateRoute,
              initialRoute: Routes.login,
            );
          },
        ),
      ),
    );
  }
}
