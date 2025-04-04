import 'package:flutter/material.dart';
import 'package:realtime_innovations_test/config/extensions/string_extension.dart';

class LocalizedText extends StatelessWidget {
  final String textKey;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final bool isUpperCase;
  final bool isSubText;

  const LocalizedText(
    this.textKey, {
    required this.textStyle,
    this.textAlign = TextAlign.left,
    this.isUpperCase = false,
    this.isSubText = false,
  });

  @override
  Widget build(BuildContext context) {
    final _localizedText = textKey.toLocalizeString;
    return Text(
      isUpperCase ? _localizedText.toUpperCase() : _localizedText,
      style: textStyle,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
