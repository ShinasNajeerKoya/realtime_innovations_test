import 'package:flutter/material.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';
import 'package:realtime_innovations_test/config/theme/text_style.dart';
import 'package:realtime_innovations_test/config/theme/units.dart';

class CustomBottomDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? value;
  final String Function(T) itemToString;
  final void Function(T?) onChanged;

  const CustomBottomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.itemToString,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        padding: allPadding8,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kGrey, width: 2),
          borderRadius: circularRadius4,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.cases_outlined,
                  color: AppColors.kPrimary,
                ),
                horizontalMargin12,
                Text(
                  value == null ? label : itemToString(value as T),
                  style: value == null ? TextStyles.h5Silver : null,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.kPrimary,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.kWhite,
      builder: (BuildContext context) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: AppColors.kGrey); // Add divider between items
          },
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return ListTile(
              title: Text(
                itemToString(item),
                textAlign: TextAlign.center,
                style: TextStyles.h4,
              ),
              onTap: () {
                onChanged(item);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
