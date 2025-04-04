import 'package:easy_localization/easy_localization.dart';

extension LocalizeStringExtension on String {
  String get toLocalizeString {
    try {
      return this.tr();
    } catch (exception) {
      return '';
    }
  }
}
