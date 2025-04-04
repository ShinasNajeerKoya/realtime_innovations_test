import 'package:hive/hive.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';

part 'employee_account_dao.g.dart';

@HiveType(typeId: 1)
class EmployeeAccountDao extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final EmployeeRoleEnumDao role;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime? lastDate;

  EmployeeAccountDao({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.lastDate,
  });
}
