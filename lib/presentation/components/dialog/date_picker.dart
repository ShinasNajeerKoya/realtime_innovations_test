import 'package:flutter/material.dart';

Future<DateTime?> selectDate(
  BuildContext context, {
  DateTime? initialDate,
}) async {
  return showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
}
