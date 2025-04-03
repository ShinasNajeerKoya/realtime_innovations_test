import 'package:realtime_innovations_test/domain/dao_controller/employee_account/employee_account_dao_controller.dart';
import 'package:realtime_innovations_test/domain/repository/manage_employee/manage_employee_repository.dart';

ManageEmployeeRepository provideManageEmployeeRepository() {
  return ManageEmployeeRepository(
    employeeAccountDaoController: EmployeeAccountDaoController(),
  );
}
