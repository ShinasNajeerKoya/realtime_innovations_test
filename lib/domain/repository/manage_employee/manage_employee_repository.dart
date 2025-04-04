import 'package:realtime_innovations_test/config/utils/string_utils.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/domain/dao_controller/employee_account/employee_account_dao_controller.dart';
import 'package:realtime_innovations_test/domain/repository/manage_employee/config/manage_employee_config.dart';

class ManageEmployeeRepository {
  final EmployeeAccountDaoController employeeAccountDaoController;

  ManageEmployeeRepository({
    required this.employeeAccountDaoController,
  });

  Future<bool> addEmployee(ManageEmployeeConfig config) async {
    final _employeeAccountDao = EmployeeAccountDao(
      id: generateId(),
      name: config.name,
      role: config.role,
      startDate: config.startDate,
      lastDate: config.lastDate,
    );
    return employeeAccountDaoController.saveOrUpdateEmployeeAccount(_employeeAccountDao);
  }

  Future<bool> updateEmployee(ManageEmployeeConfig config, {required int id}) async {
    final _employeeAccountDao = EmployeeAccountDao(
      id: id,
      name: config.name,
      role: config.role,
      startDate: config.startDate,
      lastDate: config.lastDate,
    );
    return employeeAccountDaoController.saveOrUpdateEmployeeAccount(_employeeAccountDao);
  }

  Future<EmployeeAccountDao?> searchByName(String name) async {
    return await employeeAccountDaoController.searchByName(name);
  }

  Future<List<EmployeeAccountDao>> getAllEmployeeAccountData() async {
    return await employeeAccountDaoController.getAllEmployeeAccountData();
  }

  Future<bool> deleteSelectedEmployee(EmployeeAccountDao employeeAccount) async {
    return await employeeAccountDaoController.deleteSelectedEmployee(employeeAccount);
  }
}
