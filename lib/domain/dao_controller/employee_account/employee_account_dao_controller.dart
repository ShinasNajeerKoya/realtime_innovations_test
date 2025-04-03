import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:realtime_innovations_test/config/constants/dao_box_key.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';

class EmployeeAccountDaoController {
  Future<bool> saveOrUpdateEmployeeAccount(EmployeeAccountDao employeeAccountDao) async {
    final Box<EmployeeAccountDao> _employeeBox =
        await Hive.openBox<EmployeeAccountDao>(DaoBoxKeys.employeeBox);

    try {
      final existingEmp = _employeeBox.values.firstWhereOrNull(
        (emp) => emp.id == employeeAccountDao.id,
      );

      if (existingEmp != null) {
        // If it exists, update the entry using its key
        await _employeeBox.put(existingEmp.key, employeeAccountDao);
      } else {
        // If it does not exist, add a new entry
        await _employeeBox.add(employeeAccountDao);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<EmployeeAccountDao>> getAllEmployeeAccountData() async {
    final Box<EmployeeAccountDao> _employeeBox =
        await Hive.openBox<EmployeeAccountDao>(DaoBoxKeys.employeeBox);
    List<EmployeeAccountDao> _employeeList = [];
    try {
      _employeeList = _employeeBox.values.toList();
    } catch (e) {
      //
    }
    return _employeeList;
  }

  Future<EmployeeAccountDao?> searchByName(String name) async {
    final _employeeList = await getAllEmployeeAccountData();
    return _employeeList.firstWhereOrNull((emp) => emp.name == name);
  }

  Future<bool> deleteSelectedEmployee(EmployeeAccountDao employeeAccountDao) async {
    final Box<EmployeeAccountDao> _employeeBox =
        await Hive.openBox<EmployeeAccountDao>(DaoBoxKeys.employeeBox);
    bool _status = false;
    try {
      // Check if the employeeNumber already exists
      final existingEmployee =
          _employeeBox.values.firstWhereOrNull((employee) => employee.id == employeeAccountDao.id);

      if (existingEmployee != null) {
        await _employeeBox.delete(existingEmployee.key);
        _status = true;
      }
    } catch (e) {
      _status = false;
    }
    return _status;
  }

  Future<bool> deleteAllEmployees() async {
    final Box<EmployeeAccountDao> _employeeBox =
        await Hive.openBox<EmployeeAccountDao>(DaoBoxKeys.employeeBox);
    try {
      await _employeeBox.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
