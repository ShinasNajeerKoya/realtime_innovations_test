import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mock_main.dart';

void main() {
  late SplashBloC splashBloc;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });
  setUp(() {
    splashBloc = SplashBloC();
  });

  tearDown(() {
    splashBloc.dispose();
  });

  Widget wrapWidgetMaterialApp() {
    return MockMaterialApp(
      home: Provider<SplashBloC>(
        create: (context) => splashBloc,
        dispose: (_, bloc) => bloc.dispose(),
        child: const SplashPage(),
      ),
    );
  }

  testWidgets('Trigger widgets of splashPage', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidgetMaterialApp());
    expect(find.byKey(const ValueKey('welcome_text_key')), findsOneWidget);
  });
}
