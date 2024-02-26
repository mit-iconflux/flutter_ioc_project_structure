import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';

/// TextTitle
class TextLabel extends StatelessWidget {
  /// Constructor
  const TextLabel({
    Key? key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  final String text;

  final TextAlign textAlign;

  final TextStyle? textStyle;
  final int? maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: textStyle ?? TextStyles.normal(),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
    );
  }
}
