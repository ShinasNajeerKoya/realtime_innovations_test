import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/bloc/employee_form_bloc.dart';

import '../../../mock_response/mock_employee_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late EmployeeFormBloC employeeFormBloc;
  late MockManageEmployeeRepository manageEmployeeRepository;

  setUp(() {
    manageEmployeeRepository = MockManageEmployeeRepository();
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => empList);
    employeeFormBloc = EmployeeFormBloC(manageEmployeeRepository: manageEmployeeRepository);
  });

  tearDown(() {
    employeeFormBloc.dispose();
  });

  test('Initial values should be correct', () {
    expect(employeeFormBloc.nameStream.value, '');
    expect(employeeFormBloc.selectedRole.valueOrNull, isNull);
    expect(employeeFormBloc.fromDateTime.value, isA<DateTime>());
    expect(employeeFormBloc.tillDateTime.valueOrNull, isNull);
  });

  test('EmployeeFormBloC dispose does not throw error', () async {
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => empList);

    expect(() => employeeFormBloc.dispose(), returnsNormally);
  });

  test('Should load employee details correctly', () async {
    final employeeAccount = EmployeeAccountDao(
      id: 1,
      name: 'John Doe',
      role: EmployeeRoleEnumDao.flutterDeveloper,
      startDate: DateTime(2023, 5, 10),
      lastDate: DateTime(2023, 6, 15),
    );

    final employeeFormBloC = EmployeeFormBloC(
      employeeAccountDao: employeeAccount,
      manageEmployeeRepository: manageEmployeeRepository,
    );

    await employeeFormBloC.initDetails();

    expect(employeeFormBloC.nameStream.value, 'John Doe');
    expect(employeeFormBloC.selectedRole.value, EmployeeRoleEnumDao.flutterDeveloper);
    expect(employeeFormBloC.fromDateTime.value, DateTime(2023, 5, 10));
    expect(employeeFormBloC.tillDateTime.value, DateTime(2023, 6, 15));
  });

  test('Validation should fail if name is empty', () async {
    final result = await employeeFormBloc.validateForm();
    expect(result, false);
    expect(employeeFormBloc.nameErrorStream.value, LocaleKeys.errorEmployeeName);
  });

  test('Validation should fail if role is not selected', () async {
    employeeFormBloc.nameStream.add('John Doe');
    final result = await employeeFormBloc.validateForm();
    expect(result, false);
    expect(employeeFormBloc.roleErrorStream.value, LocaleKeys.errorSelectRole);
  });

  test('Validation should pass with correct values', () async {
    employeeFormBloc.nameStream.add('John Doe');
    employeeFormBloc.selectedRole.add(EmployeeRoleEnumDao.flutterDeveloper);
    employeeFormBloc.fromDateTime.add(DateTime(2023, 5, 10));

    final result = await employeeFormBloc.validateForm();
    expect(result, true);
  });

  test('Should call addEmployee when no existing ID', () async {
    employeeFormBloc.nameStream.add('John Doe');
    employeeFormBloc.selectedRole.add(EmployeeRoleEnumDao.flutterDeveloper);
    employeeFormBloc.fromDateTime.add(DateTime(2023, 5, 10));

    when(manageEmployeeRepository.addEmployee(any)).thenAnswer((_) async => true);

    final result = await employeeFormBloc.manageEmployeeUpdate();

    expect(result, true);
    verify(manageEmployeeRepository.addEmployee(any)).called(1);
  });

  test('Should call updateEmployee when updating an existing employee', () async {
    final employeeAccount = EmployeeAccountDao(
      id: 1,
      name: 'John Doe',
      role: EmployeeRoleEnumDao.flutterDeveloper,
      startDate: DateTime(2023, 5, 10),
      lastDate: DateTime(2023, 6, 15),
    );

    final employeeFormBloC = EmployeeFormBloC(
      employeeAccountDao: employeeAccount,
      manageEmployeeRepository: manageEmployeeRepository,
    );

    employeeFormBloC.nameStream.add('Updated Name');
    employeeFormBloC.selectedRole.add(EmployeeRoleEnumDao.flutterDeveloper);

    when(manageEmployeeRepository.updateEmployee(any, id: anyNamed('id'))).thenAnswer((_) async => true);

    final result = await employeeFormBloC.manageEmployeeUpdate();

    expect(result, true);
    verify(manageEmployeeRepository.updateEmployee(any, id: 1)).called(1);
  });
}

final empList = MockEmployeeData().employeesList;
