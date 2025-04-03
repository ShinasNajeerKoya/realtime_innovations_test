import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/config/extensions/date_extension.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';
import 'package:realtime_innovations_test/config/theme/text_style.dart';
import 'package:realtime_innovations_test/config/theme/units.dart';
import 'package:realtime_innovations_test/config/theme/visuals.dart';
import 'package:realtime_innovations_test/core/routes/route_name.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_svg_icon.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/localized_text.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/employee_form_page.dart';
import 'package:realtime_innovations_test/presentation/features/employee_list/bloc/employee_list_bloc.dart';

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  EmployeeListBloC? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc ??= Provider.of<EmployeeListBloC>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGrey,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        title: LocalizedText(
          LocaleKeys.employeeList,
          textStyle: TextStyles.h3White,
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<List<EmployeeAccountDao>>(
        stream: bloc!.currentEmployeesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return emptyWidget;
          }
          final _currentList = snapshot.data ?? [];
          return StreamBuilder<List<EmployeeAccountDao>>(
            stream: bloc!.previousEmployeesList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return emptyWidget;
              }
              final _previousList = snapshot.data ?? [];
              if (_currentList.isEmpty && _previousList.isEmpty) {
                return const Center(child: CustomSvgIcon(AppIcons.kNoEmployee));
              } else {
                return ListView(
                  children: [
                    _EmployeesList(
                      headerKey: LocaleKeys.currentEmployees,
                      employeesList: _currentList,
                    ),
                    _EmployeesList(
                      headerKey: LocaleKeys.previousEmployees,
                      employeesList: _previousList,
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimary,
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteName.addEmployee,
            arguments: EmployeeFormPageArguments(),
          ).then((_) {
            bloc!.initDetails();
          });
        },
        child: Icon(
          Icons.add,
          color: AppColors.kWhite,
          size: 25.sp,
        ),
      ),
    );
  }
}

class _EmployeesList extends StatelessWidget {
  final String headerKey;
  final List<EmployeeAccountDao> employeesList;

  const _EmployeesList({
    required this.headerKey,
    required this.employeesList,
  });

  @override
  Widget build(BuildContext context) {
    if (employeesList.isEmpty) {
      return emptyWidget;
    }
    final _bloc = Provider.of<EmployeeListBloC>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: allPadding16,
          child: LocalizedText(
            headerKey,
            textStyle: TextStyles.h5.copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.w700),
          ),
        ),
        ColoredBox(
          color: AppColors.kWhite,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final employee = employeesList[index];
              return Dismissible(
                key: Key(employee.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: AppColors.kRed,
                  child: const CustomSvgIcon(AppIcons.kDelete),
                ),
                onDismissed: (direction) {
                  _bloc.deleteSelectedEmployee(employee).then((_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: LocalizedText(
                            LocaleKeys.employeeDataDeleted,
                            textStyle: TextStyles.tinyWhite,
                          ),
                        ),
                      );
                    }
                  });
                },
                child: ListTile(
                  title: Text(employee.name, style: TextStyles.h2),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.role.value,
                        style: TextStyles.h6Silver,
                      ),
                      if (employee.lastDate == null)
                        Text(
                          'From ${employee.startDate.dateFormatWithComma}',
                          style: TextStyles.h6Silver,
                        )
                      else
                        Text(
                          '${employee.startDate.dateFormatWithComma} - ${employee.lastDate!.dateFormatWithComma}',
                          style: TextStyles.h6Silver,
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.addEmployee,
                      arguments: EmployeeFormPageArguments(employeeAccountDao: employee),
                    ).then((_) {
                      _bloc.initDetails();
                    });
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: AppColors.kGrey);
            },
            itemCount: employeesList.length,
          ),
        ),
      ],
    );
  }
}
