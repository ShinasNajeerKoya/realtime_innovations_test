import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  final String iconPath;
  final double? height;
  final double? width;
  final Color? color;
  final BlendMode blendMode;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  const CustomSvgIcon(
    this.iconPath, {
    this.height,
    this.width,
    this.color,
    this.blendMode = BlendMode.srcIn,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: height,
      fit: fit,
      width: width,
      alignment: alignment,
      colorFilter: color == null ? null : ColorFilter.mode(color!, blendMode),
    );
  }
}
