import 'package:flutter/material.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.kPrimary,
      primaryColorDark: AppColors.kBlack,
      canvasColor: AppColors.kWhite,
      scaffoldBackgroundColor: AppColors.kWhite,
    );
  }
}
