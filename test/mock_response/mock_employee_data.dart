import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';

class MockEmployeeData {
  List<EmployeeAccountDao> employeesList = [
    EmployeeAccountDao(
      id: 1,
      name: 'Alice Johnson',
      role: EmployeeRoleEnumDao.productOwner,
      startDate: DateTime(2010, 12, 10),
    ),
    EmployeeAccountDao(
      id: 2,
      name: 'Bob Smith',
      role: EmployeeRoleEnumDao.flutterDeveloper,
      startDate: DateTime(2020, 12, 10),
    ),
    EmployeeAccountDao(
      id: 3,
      name: 'Charlie Williams',
      role: EmployeeRoleEnumDao.qaTester,
      startDate: DateTime(2024, 12, 10),
    ),
    EmployeeAccountDao(
      id: 4,
      name: 'David Brown',
      role: EmployeeRoleEnumDao.productDesigner,
      startDate: DateTime(2019, 12, 10),
    ),
    EmployeeAccountDao(
      id: 5,
      name: 'Emily Davis',
      role: EmployeeRoleEnumDao.productDesigner,
      startDate: DateTime(2019, 12, 10),
      lastDate: DateTime(2024, 10, 10),
    ),
    EmployeeAccountDao(
      id: 6,
      name: 'Frank Miller',
      role: EmployeeRoleEnumDao.productDesigner,
      startDate: DateTime(2019, 12, 10),
      lastDate: DateTime(2020, 10, 10),
    ),
  ];
}
