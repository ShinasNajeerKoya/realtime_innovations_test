import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';

class ManageEmployeeConfig {
  final String name;
  final EmployeeRoleEnumDao role;
  final DateTime startDate;
  final DateTime? lastDate;

  ManageEmployeeConfig({
    required this.name,
    required this.role,
    required this.startDate,
    this.lastDate,
  });
}
