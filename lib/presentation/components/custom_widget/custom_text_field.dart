import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_test/config/extensions/string_extension.dart';
import 'package:realtime_innovations_test/config/theme/colors.dart';
import 'package:realtime_innovations_test/config/theme/text_style.dart';
import 'package:realtime_innovations_test/config/theme/units.dart';
import 'package:realtime_innovations_test/generated/locale_keys.g.dart';
import 'package:realtime_innovations_test/presentation/components/custom_widget/localized_text.dart';

class CustomTextField extends StatefulWidget {
  final Stream<String> textStream;
  final Stream<FocusNode>? focusNodeStream;
  final String hintTextKey;
  final void Function(String) onTextChanged;
  final VoidCallback? onTap;
  final void Function(String)? onSubmitted;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final int? maxLines;
  final int? minLines;
  final TextInputType textInputType;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Stream<String>? errorStream;
  final bool enabled;
  final bool obscureText;
  final bool enableSelection;
  final bool alignLabelWithHint;
  final TextStyle? textStyle;
  final TextCapitalization? textCapitalization;
  final TextStyle? hintStyle;
  final TextStyle? headerTextStyle;
  final double fieldHeight;
  final double fieldWidth;
  final bool autoFocus;
  final bool isEmptyError;
  final bool hideBorder;
  final bool filled;
  final Color filledColor;
  final double borderWidth;
  final InputDecoration? inputDecoration;
  final bool isMandatory;

  const CustomTextField({
    super.key,
    required this.textStream,
    this.hintTextKey = LocaleKeys.blank,
    required this.onTextChanged,
    this.textStyle,
    this.onTap,
    this.onSubmitted,
    this.textInputType = TextInputType.text,
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.minLines = 1,
    this.maxLines = 1,
    this.textInputAction,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.alignLabelWithHint = false,
    this.errorStream,
    this.enabled = true,
    this.obscureText = false,
    this.enableSelection = true,
    this.focusNodeStream,
    this.textCapitalization,
    this.hintStyle,
    this.headerTextStyle,
    this.fieldHeight = 50,
    this.fieldWidth = 412,
    this.autoFocus = false,
    this.hideBorder = false,
    this.filled = false,
    this.filledColor = AppColors.kGrey,
    this.isEmptyError = true,
    this.inputDecoration,
    this.isMandatory = false,
    this.borderWidth = 2,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.textStream.listen((value) {
      if (value.isEmpty) {
        _controller.clear();
      } else if (_controller.text != value) {
        _controller.text = value;
      }
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<String>(
          stream: widget.textStream,
          builder: (context, textStreamSnapshot) {
            if (!textStreamSnapshot.hasData) {
              return Container();
            } else {
              return StreamBuilder<FocusNode>(
                stream: widget.focusNodeStream,
                builder: (context, focusSnapshot) {
                  return InkWell(
                    onTap: widget.onTap,
                    child: SizedBox(
                      height: widget.fieldHeight.h,
                      width: widget.fieldWidth.w,
                      child: TextField(
                        textAlign: widget.textAlign,
                        textAlignVertical: widget.textAlignVertical,
                        enableInteractiveSelection: widget.enableSelection,
                        enabled: widget.enabled,
                        controller: _controller,
                        maxLines: widget.maxLines,
                        minLines: widget.minLines,
                        onTap: widget.onTap,
                        cursorColor: AppColors.kPrimary,
                        keyboardType: widget.textInputType,
                        textInputAction: widget.textInputAction,
                        onSubmitted: widget.onSubmitted,
                        obscureText: widget.obscureText,
                        autofocus: widget.autoFocus,
                        textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
                        inputFormatters: [...?widget.inputFormatters],
                        focusNode: focusSnapshot.data,
                        style: widget.textStyle,
                        decoration: widget.inputDecoration ??
                            InputDecoration(
                              suffix: widget.suffix,
                              prefix: widget.prefix,
                              suffixIcon: widget.suffixIcon,
                              prefixIcon: widget.prefixIcon,
                              alignLabelWithHint: widget.alignLabelWithHint,
                              hintText: widget.hintTextKey.toLocalizeString,
                              hintStyle:  TextStyles.h5Silver,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                              fillColor: widget.filledColor,
                              filled: widget.filled,
                              border: _inputBorder(),
                              enabledBorder: _inputBorder(),
                              disabledBorder: _inputBorder(),
                              focusedBorder: _inputBorder(
                                color: AppColors.kPrimary,
                              ),
                            ),
                        onChanged: (text) => widget.onTextChanged(text),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        _ErrorTextWidget(
          textStream: widget.textStream,
          errorStream: widget.errorStream,
          isEmptyError: widget.isEmptyError,
        ),
      ],
    );
  }

  InputBorder _inputBorder({Color? color}) {
    if (widget.hideBorder) {
      return InputBorder.none;
    } else {
      return OutlineInputBorder(
        borderSide: BorderSide(color: color ?? widget.filledColor, width: widget.borderWidth),
        borderRadius: circularRadius4,
      );
    }
  }
}

class _ErrorTextWidget extends StatelessWidget {
  final Stream<String> textStream;
  final Stream<String>? errorStream;
  final bool isEmptyError;

  const _ErrorTextWidget({
    required this.textStream,
    this.errorStream,
    required this.isEmptyError,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: errorStream,
      builder: (context, snapshot) {
        final _error = snapshot.data ?? '';
        return StreamBuilder<String>(
          stream: textStream,
          builder: (context, textSnapshot) {
            final _textData = textSnapshot.data ?? '';
            if ((_error.isNotEmpty && _error != LocaleKeys.blank) &&
                ((isEmptyError && _textData.isEmpty) || !isEmptyError)) {
              return LocalizedText(
                _error,
                textStyle:  TextStyles.h6.copyWith(color: AppColors.kRed),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
