import 'package:realtime_innovations_test/core/bloc/app_bloc.dart';
import 'package:realtime_innovations_test/core/repository/repository_provider.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/bloc/employee_form_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/bloc/employee_list_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/splash/bloc/splash_bloc.dart';

AppBloC provideAppBloC() {
  return AppBloC();
}

SplashBloC provideSplashBloC() {
  return SplashBloC();
}

EmployeeListBloC provideEmployeeListBloC() {
  return EmployeeListBloC(
    manageEmployeeRepository: provideManageEmployeeRepository(),
  );
}

EmployeeFormBloC provideEmployeeFormBloC({EmployeeAccountDao? employeeAccount}) {
  return EmployeeFormBloC(
    employeeAccountDao: employeeAccount,
    manageEmployeeRepository: provideManageEmployeeRepository(),
  );
}
