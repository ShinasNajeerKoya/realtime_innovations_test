import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/config/theme/text_style.dart';
import 'package:realtime_innovations_test/core/routes/route_name.dart';
import 'package:realtime_innovations_test/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloC? bloc;
  StreamSubscription? _subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (bloc == null) {
      bloc = Provider.of<SplashBloC>(context);

      _subscription ??= bloc!.showPage.debounceTime(const Duration(milliseconds: 500)).listen(handlePageNavigation);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyles.h1,
        ),
      ),
    );
  }

  Future<void> handlePageNavigation(String event) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteName.employeeList,
      (route) => false,
    );
  }
}
