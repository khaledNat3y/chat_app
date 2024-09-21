import 'package:chat_app/core/di/dependency_injection.dart';
import 'package:chat_app/core/routing/app_router.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/home/logic/home_cubit.dart';
import 'package:chat_app/features/settings/logic/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

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
          BlocProvider(create: (_) => getIt<HomeCubit>(),),
        ],
        child: BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
          child: BlocBuilder<SettingsCubit, Locale>(
            builder: (context, state) {
              return MaterialApp(

                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(state.languageCode),  // Use the locale from the SettingsCubit
                debugShowCheckedModeBanner: false,
                builder: EasyLoading.init(),

                title: 'MindMate',
                onGenerateRoute: appRouter.generateRoute,
                initialRoute: Routes.login,
              );
            },
          ),
        ),
      ),
    );
  }
}