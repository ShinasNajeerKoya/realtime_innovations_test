import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/config/theme/theme.dart';
import 'package:realtime_innovations_test/core/bloc/app_bloc.dart';
import 'package:realtime_innovations_test/core/bloc/bloc_provider.dart';
import 'package:realtime_innovations_test/core/hive_adapters/hive_adapters.dart';
import 'package:realtime_innovations_test/core/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  await Hive.initFlutter();

  registerHiveAdapters();

  runApp(
    EasyLocalization(
      path: 'assets/languages',
      supportedLocales: const <Locale>[
        Locale('en'),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AppBloC>(
      create: (_) => provideAppBloC(),
      dispose: (_, bloc) => bloc.dispose(),
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
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.theme,
        routes: routes,
        onGenerateRoute: (settings) => generatedRoutes(settings),
      ),
    );
  }
}
