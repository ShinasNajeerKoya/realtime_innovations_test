import 'package:realtime_innovations_test/config/extensions/date_extension.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';
import 'package:realtime_innovations_test/domain/repository/manage_employee/config/manage_employee_config.dart';
import 'package:realtime_innovations_test/domain/repository/manage_employee/manage_employee_repository.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeFormBloC {
  final EmployeeAccountDao? employeeAccountDao;
  final ManageEmployeeRepository manageEmployeeRepository;

  final nameStream = BehaviorSubject<String>.seeded('');
  final nameErrorStream = BehaviorSubject<String>();

  final selectedRole = BehaviorSubject<EmployeeRoleEnumDao?>();
  final roleErrorStream = BehaviorSubject<String>();

  final fromDateTime = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final fromDateStream = BehaviorSubject<String>.seeded(DateTime.now().convertToDateFormat);
  final fromDateError = BehaviorSubject<String>.seeded('');

  final tillDateTime = BehaviorSubject<DateTime?>();
  final tillDateStream = BehaviorSubject<String>.seeded('No date');

  EmployeeFormBloC({this.employeeAccountDao, required this.manageEmployeeRepository}) {
    initDetails();
  }

  Future<void> initDetails() async {
    await _loadAllEmployee();
  }

  Future<void> _loadAllEmployee() async {
    if (employeeAccountDao != null) {
      nameStream.add(employeeAccountDao!.name);
      selectedRole.add(employeeAccountDao!.role);
      await handleDateSelection(employeeAccountDao?.startDate, isFromDate: true);
      await handleDateSelection(employeeAccountDao?.lastDate, isFromDate: false);
    }
  }

  Future<void> handleDateSelection(DateTime? picked, {required bool isFromDate}) async {
    if (picked != null) {
      if (isFromDate) {
        fromDateTime.add(picked);
        fromDateStream.add(picked.convertToDateFormat);
      } else {
        tillDateTime.add(picked);
        tillDateStream.add(picked.convertToDateFormat);
      }
    }
  }

  Future<bool> manageEmployeeUpdate() async {
    if (await validateForm()) {
      final _config = ManageEmployeeConfig(
        name: nameStream.value,
        role: selectedRole.value!,
        startDate: fromDateTime.value,
        lastDate: tillDateTime.valueOrNull,
      );

      if (employeeAccountDao == null) {
        return manageEmployeeRepository.addEmployee(_config);
      } else {
        return manageEmployeeRepository.updateEmployee(_config, id: employeeAccountDao!.id);
      }
    }
    return false;
  }

  Future<bool> validateForm() async {
    bool _status = true;

    if (nameStream.value.isEmpty) {
      nameErrorStream.add(LocaleKeys.errorEmployeeName);
      _status = false;
    } else {
      nameErrorStream.add(LocaleKeys.blank);
    }

    if (selectedRole.valueOrNull == null) {
      roleErrorStream.add(LocaleKeys.errorSelectRole);
      _status = false;
    } else {
      roleErrorStream.add(LocaleKeys.blank);
    }

    if (fromDateStream.value.isEmpty) {
      fromDateError.add(LocaleKeys.errorSelectStartDate);
      _status = false;
    } else {
      fromDateError.add(LocaleKeys.blank);
    }
    if (tillDateTime.valueOrNull != null && tillDateTime.value!.isBefore(fromDateTime.value)) {
      fromDateError.add(LocaleKeys.errorSelectValidDates);
      _status = false;
    } else {
      fromDateError.add(LocaleKeys.blank);
    }

    return _status;
  }

  void dispose() {}
}
