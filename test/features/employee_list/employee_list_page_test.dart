import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/bloc/employee_list_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/employee_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mock_main.dart';
import '../../mock_response/mock_employee_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late EmployeeListBloC employeeListBloc;
  late MockManageEmployeeRepository manageEmployeeRepository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    manageEmployeeRepository = MockManageEmployeeRepository();
    when(manageEmployeeRepository.getAllEmployeeAccountData()).thenAnswer((_) async => empList);
    employeeListBloc = EmployeeListBloC(manageEmployeeRepository: manageEmployeeRepository);
  });

  tearDown(() {
    employeeListBloc.dispose();
  });

  Widget wrapWidgetMaterialApp() {
    return MockMaterialApp(
      home: Provider<EmployeeListBloC>(
        create: (context) => employeeListBloc,
        dispose: (_, bloc) => bloc.dispose(),
        child: EmployeeListPage(),
      ),
    );
  }

  testWidgets('Trigger widgets of EmployeeListPage', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidgetMaterialApp());
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('employee_list_header_key')), findsOneWidget);
    expect(find.byKey(const ValueKey('floating_action_button')), findsOneWidget);

    (tester.allWidgets.firstWhere((element) => element.runtimeType == FloatingActionButton)
            as FloatingActionButton)
        .onPressed
        ?.call();
  });
}

final empList = MockEmployeeData().employeesList;
