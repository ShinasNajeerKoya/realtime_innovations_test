import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/domain/repository/manage_employee/manage_employee_repository.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeListBloC {
  final ManageEmployeeRepository manageEmployeeRepository;

  final currentEmployeesList = BehaviorSubject<List<EmployeeAccountDao>>();
  final previousEmployeesList = BehaviorSubject<List<EmployeeAccountDao>>();

  EmployeeListBloC({required this.manageEmployeeRepository}) {
    initDetails();
  }

  Future<void> initDetails() async {
    await _loadAllEmployees();
  }

  Future<void> _loadAllEmployees() async {
    final _list = await manageEmployeeRepository.getAllEmployeeAccountData();
    final today = DateTime.now();

    final _currentEmployees =
        _list.where((employee) => employee.lastDate == null || employee.lastDate!.isAfter(today)).toList();
    currentEmployeesList.add(_currentEmployees);

    final _previousEmployees =
        _list.where((employee) => employee.lastDate != null && employee.lastDate!.isBefore(today)).toList();
    previousEmployeesList.add(_previousEmployees);
  }

  Future<void> deleteSelectedEmployee(EmployeeAccountDao employeeAccount) async {
    await manageEmployeeRepository.deleteSelectedEmployee(employeeAccount);

    await _loadAllEmployees();
  }

  void dispose() {}
}
