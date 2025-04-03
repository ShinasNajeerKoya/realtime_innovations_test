import 'package:easy_localization/easy_localization.dart';
import 'package:realtime_innovations_test/config/extensions/string_extension.dart';
import 'package:realtime_innovations_test/config/utils/misc_util.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';

extension DateExtension on DateTime {
  String get convertToDateFormat {
    return isToday(this) ? LocaleKeys.today.toLocalizeString : DateFormat('dd MMM yyyy').format(this);
  }

  String get dateFormatWithComma {
    return DateFormat('dd MMM, yyyy').format(this);
  }
}
