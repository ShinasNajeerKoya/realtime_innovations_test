import 'package:hive/hive.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(EmployeeRoleEnumDaoAdapter());
  Hive.registerAdapter(EmployeeAccountDaoAdapter());
}
