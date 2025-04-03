import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_test/config/theme/theme.dart';
import 'package:realtime_innovations_test/main.dart';

class MockMaterialApp extends StatelessWidget {
  final Widget home;

  const MockMaterialApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/languages',
      supportedLocales: const <Locale>[
        Locale('en'),
      ],
      fallbackLocale: const Locale('en'),
      child: MaterialApp(
        builder: (context, child) {
          //ignore system scale factor
          ScreenUtil.init(
            context,
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
          );
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: child ?? Container(),
          );
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => home,
          );
        },
        home: home,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
        theme: AppTheme.theme,
        // routes: routes,
        // onGenerateRoute: (settings) => generatedRoutes(settings),
      ),
    );
  }
}
