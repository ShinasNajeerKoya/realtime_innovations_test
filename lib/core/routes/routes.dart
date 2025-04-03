import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/core/bloc/bloc_provider.dart';
import 'package:realtime_innovations_test/core/routes/page_route_builder.dart';
import 'package:realtime_innovations_test/core/routes/route_name.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/bloc/employee_form_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/employee_form_page.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/bloc/employee_list_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/employee_list_page.dart';
import 'package:realtime_innovations_test/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/splash/splash_page.dart';

var routes = <String, WidgetBuilder>{
  RouteName.firstRoute: (context) => Provider<SplashBloC>(
        create: (context) => provideSplashBloC(),
        dispose: (_, bloc) => bloc.dispose(),
        child: const SplashPage(),
      ),
};

Route<dynamic>? generatedRoutes(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');
  switch (uri.path) {
    case RouteName.employeeList:
      return createPageRoute(
        builder: (context) => Provider<EmployeeListBloC>(
          create: (context) => provideEmployeeListBloC(),
          dispose: (_, bloc) => bloc.dispose(),
          child: EmployeeListPage(),
        ),
        transition: TransitionType.scale,
      );

    case RouteName.addEmployee:
    case RouteName.updateEmployee:
      if (settings.arguments != null && settings.arguments is EmployeeFormPageArguments) {
        return _getEmployeeFormPage(
          settings.arguments! as EmployeeFormPageArguments,
        );
      }
  }

  return null;
}

PageRouteBuilder _getEmployeeFormPage(EmployeeFormPageArguments argument) {
  return createPageRoute(
    builder: (context) => Provider<EmployeeFormBloC>(
      create: (context) => provideEmployeeFormBloC(employeeAccount: argument.employeeAccountDao),
      dispose: (_, bloc) => bloc.dispose(),
      child: EmployeeFormPage(),
    ),
    transition: TransitionType.slideLeft,
  );
}
