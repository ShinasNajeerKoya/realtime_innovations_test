import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:realtime_innovations_test/config/extensions/string_extension.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';
import 'package:realtime_innovations_test/config/theme/text_style.dart';
import 'package:realtime_innovations_test/config/theme/units.dart';
import 'package:realtime_innovations_test/config/theme/visuals.dart';
import 'package:realtime_innovations_test/data/dao/employee_account/employee_account_dao.dart';
import 'package:realtime_innovations_test/data/dao/enum_dao/employee_role_enum.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_bottom_dropdown.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_button.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_svg_icon.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/custom_text_field.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/localized_text.dart';
import 'package:realtime_innovations_test/presentation/components/dialog/date_picker.dart';
import 'package:realtime_innovations_test/presentation/features/employee_form/bloc/employee_form_bloc.dart';

class EmployeeFormPage extends StatefulWidget {
  @override
  _EmployeeFormPageState createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  EmployeeFormBloC? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc ??= Provider.of<EmployeeFormBloC>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        title: LocalizedText(
          bloc!.employeeAccountDao == null ? LocaleKeys.addEmployeeDetails : LocaleKeys.editEmployeeDetails,
          textStyle: TextStyles.h3White,
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: horizontalPadding16,
        child: Column(
          children: [
            verticalMargin16,
            CustomTextField(
              textStream: bloc!.nameStream,
              onTextChanged: bloc!.nameStream.add,
              errorStream: bloc!.nameErrorStream,
              prefixIcon: Icon(
                Icons.person,
                color: AppColors.kPrimary,
                size: 20.r,
              ),
              hintTextKey: LocaleKeys.employeeName,
            ),
            verticalMargin8,
            StreamBuilder<EmployeeRoleEnumDao?>(
              stream: bloc!.selectedRole,
              builder: (context, snapshot) {
                return CustomBottomDropdown<EmployeeRoleEnumDao>(
                  label: LocaleKeys.selectRole.toLocalizeString,
                  items: EmployeeRoleEnumDao.values,
                  value: snapshot.data,
                  itemToString: (EmployeeRoleEnumDao item) => item.value,
                  onChanged: (EmployeeRoleEnumDao? newValue) {
                    bloc!.selectedRole.add(newValue);
                  },
                );
              },
            ),
            verticalMargin8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: CustomTextField(
                    textStream: bloc!.fromDateStream,
                    onTextChanged: bloc!.fromDateStream.add,
                    errorStream: bloc!.fromDateError,
                    fieldWidth: 150,
                    enabled: false,
                    isMandatory: true,
                    isEmptyError: false,
                    textStyle: TextStyles.h6,
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                      color: AppColors.kPrimary,
                    ),
                    onTap: () => selectDate(context).then(
                      (picked) => bloc!.handleDateSelection(picked, isFromDate: true),
                    ),
                  ),
                ),
                Padding(
                  padding: topPadding12,
                  child: const CustomSvgIcon(AppIcons.kArrowRight),
                ),
                CustomTextField(
                  textStream: bloc!.tillDateStream,
                  onTextChanged: bloc!.tillDateStream.add,
                  enabled: false,
                  fieldWidth: 150,
                  isMandatory: true,
                  textStyle: TextStyles.h6,
                  prefixIcon: const Icon(
                    Icons.calendar_month,
                    color: AppColors.kPrimary,
                  ),
                  onTap: () => selectDate(context).then(
                    (picked) => bloc!.handleDateSelection(picked, isFromDate: false),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: ColoredBox(
        color: AppColors.kWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              color: AppColors.kGrey,
              thickness: 2,
            ),
            Padding(
              padding: horizontalPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    buttonTextKey: LocaleKeys.cancel,
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    filledColor: AppColors.kSecondary,
                    textColor: AppColors.kPrimary,
                  ),
                  horizontalMargin8,
                  CustomButton(
                    buttonTextKey: LocaleKeys.save,
                    onTap: () {
                      bloc!.manageEmployeeUpdate().then((result) {
                        if (result && context.mounted) {
                          Navigator.pop(context, false);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            verticalMargin16,
          ],
        ),
      ),
    );
  }
}

class EmployeeFormPageArguments {
  final EmployeeAccountDao? employeeAccountDao;

  EmployeeFormPageArguments({this.employeeAccountDao});
}
