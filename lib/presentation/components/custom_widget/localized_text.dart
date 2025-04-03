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

    /// if language is not english, font may need to resize in order to fix overflow bug
    // final _fixedFontSizeFontSize = ['en'].contains(context.locale.languageCode);

    return Text(
      isUpperCase ? _localizedText.toUpperCase() : _localizedText,
      // style: isSubText ? textStyle.copyWith(fontSize: _subTextFontSize()) : textStyle,
      // style: _fixedFontSize
      //     ? textStyle
      //     : textStyle.copyWith(fontSize: _fontSize()),
      style: textStyle,
      textAlign: textAlign,
      softWrap: true,
    );
  }

  /*double? _fontSize() {
    final _length = getLocalizeString(textKey).length;
    if (_length > 40) {
      return isSubText ? 5.sp : checkForFontSize(9.sp);
    } else if (_length > 30) {
      return isSubText ? 6.sp : checkForFontSize(10.sp);
    } else if (_length > 25) {
      return isSubText ? 7.sp : checkForFontSize(11.sp);
    } else if (_length > 20) {
      return isSubText ? 8.sp : checkForFontSize(11.sp);
    } else if (_length > 15) {
      return isSubText ? 9.sp : checkForFontSize(12.sp);
    } else {
      return textStyle.fontSize;
    }
  }*/

  double? checkForFontSize(double size) {
    if (size > textStyle.fontSize!) {
      return textStyle.fontSize;
    } else {
      return size;
    }
  }
}
