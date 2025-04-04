import 'package:flutter_test/flutter_test.dart';
import 'package:realtime_innovations_test/presentation/features/splash/bloc/splash_bloc.dart';

void main() {
  late SplashBloC splashBloc;

  setUp(() {
    splashBloc = SplashBloC();
  });

  tearDown(() {
    splashBloc.dispose();
  });

  test('SplashBloC emits "Navigate" after 500ms', () async {
    expectLater(
      splashBloc.showPage,
      emits('Navigate'),
    );

    await Future.delayed(const Duration(milliseconds: 600));
  });

  test('SplashBloC dispose does not throw error', () {
    expect(() => splashBloc.dispose(), returnsNormally);
  });
}
