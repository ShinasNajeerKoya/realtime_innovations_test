import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/bloc/employee_list_bloc.dart';

import '../../../mock_response/mock_employee_data.dart';
import '../../../mocks.mocks.dart';

void main() {
  late EmployeeListBloC employeeListBloc;
  late MockManageEmployeeRepository manageEmployeeRepository;

  setUp(() {
    manageEmployeeRepository = MockManageEmployeeRepository();
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => empList);
    employeeListBloc = EmployeeListBloC(manageEmployeeRepository: manageEmployeeRepository);
  });

  tearDown(() {
    employeeListBloc.dispose();
  });

  test('Should categorize employees correctly into current and previous employees', () async {
    // Arrange (Mock Data)
    final today = DateTime.now();
    final allEmployees = empList;

    final currentEmployee = allEmployees
        .where((employee) => employee.lastDate == null || employee.lastDate!.isAfter(today))
        .toList();
    final previousEmployee = allEmployees
        .where((employee) => employee.lastDate != null && employee.lastDate!.isBefore(today))
        .toList();

    // Stub method BEFORE calling initDetails()
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => allEmployees);

    // Act
    await employeeListBloc.initDetails();

    // Assert
    expect(employeeListBloc.currentEmployeesList.value, currentEmployee);
    expect(employeeListBloc.previousEmployeesList.value, previousEmployee);
  });

  test('EmployeeListBloC dispose does not throw error', () async {
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => empList);

    expect(() => employeeListBloc.dispose(), returnsNormally);
  });

  test('Should remove an employee and update the list after deletion', () async {
    final employeeToDelete = empList.first;

    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => [employeeToDelete]);

    await employeeListBloc.initDetails();

    when(manageEmployeeRepository.deleteSelectedEmployee(employeeToDelete)).thenAnswer((_) async => true);
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => []);

    await employeeListBloc.deleteSelectedEmployee(employeeToDelete);

    verify(manageEmployeeRepository.deleteSelectedEmployee(employeeToDelete)).called(1);
    expect(employeeListBloc.currentEmployeesList.value, isEmpty);
  });
}

final empList = MockEmployeeData().employeesList;
