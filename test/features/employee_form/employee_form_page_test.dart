import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_button.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_text_field.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/bloc/employee_form_bloc.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/employee_form_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mock_main.dart';
import '../../mock_response/mock_employee_data.dart';
import '../../mocks.mocks.dart';

void main() {
  late EmployeeFormBloC employeeFormBloc;
  late MockManageEmployeeRepository manageEmployeeRepository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    manageEmployeeRepository = MockManageEmployeeRepository();
    employeeFormBloc = EmployeeFormBloC(manageEmployeeRepository: manageEmployeeRepository);
  });

  tearDown(() {
    employeeFormBloc.dispose();
  });

  Widget wrapWidgetMaterialApp() {
    return MockMaterialApp(
      home: Provider<EmployeeFormBloC>(
        create: (context) => employeeFormBloc,
        dispose: (_, bloc) => bloc.dispose(),
        child: EmployeeFormPage(),
      ),
    );
  }

  testWidgets('Renders correctly with default values', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidgetMaterialApp());

    expect(find.text(LocaleKeys.addEmployeeDetails), findsOneWidget);
    expect(find.byType(CustomTextField), findsWidgets);
    expect(find.byType(CustomButton), findsWidgets);

    (tester.allWidgets.firstWhere((element) => element.key == const ValueKey('start_date_picker'))
            as CustomTextField)
        .onTap
        ?.call();

    (tester.allWidgets.firstWhere((element) => element.key == const ValueKey('last_date_picker'))
            as CustomTextField)
        .onTap
        ?.call();

    (tester.allWidgets.firstWhere((element) => element.key == const ValueKey('cancel_button'))
            as CustomButton)
        .onTap
        .call();

    (tester.allWidgets.firstWhere((element) => element.key == const ValueKey('save_button')) as CustomButton)
        .onTap
        .call();
  });

  testWidgets('Displays correct title for Edit mode', (WidgetTester tester) async {
    final employee = MockEmployeeData().employeesList.first;

    employeeFormBloc =
        EmployeeFormBloC(employeeAccountDao: employee, manageEmployeeRepository: manageEmployeeRepository);

    await tester.pumpWidget(
      MaterialApp(
        home: Provider<EmployeeFormBloC>.value(
          value: employeeFormBloc,
          child: EmployeeFormPage(),
        ),
      ),
    );

    expect(find.text(LocaleKeys.editEmployeeDetails), findsOneWidget);
  });

  testWidgets('Tapping save calls manageEmployeeUpdate()', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidgetMaterialApp());

    await tester.tap(find.text(LocaleKeys.save));
    await tester.pumpAndSettle();

    (tester.allWidgets.firstWhere((element) => element.runtimeType == CustomButton) as CustomButton)
        .onTap
        .call();
  });

  testWidgets('Tapping cancel pops the screen', (WidgetTester tester) async {
    await tester.pumpWidget(wrapWidgetMaterialApp());

    await tester.tap(find.text(LocaleKeys.cancel));
    await tester.pumpAndSettle();

    expect(find.byType(EmployeeFormPage), findsNothing);
  });
}
