import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';
import 'package:realtime_innovations_test/config/theme/text_style.dart';
import 'package:realtime_innovations_test/config/theme/units.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/localized_text.dart';

class CustomButton extends StatelessWidget {
  final String buttonTextKey;
  final Color textColor;
  final Color filledColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.buttonTextKey,
    this.textColor = AppColors.kWhite,
    this.filledColor = AppColors.kPrimary,
    this.buttonHeight,
    this.buttonWidth,
    required this.onTap,
    this.textStyle,
    this.borderRadius,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: buttonHeight?.h,
        width: buttonWidth?.w,
        decoration: BoxDecoration(
          border: borderColor == null ? null : Border.all(color: borderColor!),
          color: filledColor,
          borderRadius: borderRadius ?? circularRadius6,
        ),
        padding: padding ?? horizontal16Vertical8Padding,
        child: LocalizedText(
          buttonTextKey,
          textStyle: textStyle ?? TextStyles.h6.copyWith(color: textColor),
        ),
      ),
    );
  }
}
