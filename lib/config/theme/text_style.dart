import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';

class TextStyles {
  const TextStyles._();

  static final h1 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 26.sp,
  );

  static final h2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp);

  static final h3 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final h3White = h3.copyWith(
    color: AppColors.kWhite,
  );

  static final h4 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final h5 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final h5Silver = h5.copyWith(
    color: AppColors.kSilver,
  );

  static final h6 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );

  static final h6Silver = h6.copyWith(
    color: AppColors.kSilver,
  );

  static final tinyWhite = TextStyle(fontSize: 10.sp, color: AppColors.kWhite);
}
