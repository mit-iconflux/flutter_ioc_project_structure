import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary({
    Key? key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.minHeight = 50,
    this.isCenter = false,
    this.textColor,
    this.bgColor,
  }) : super(key: key);
  final String text;
  final VoidCallback? onTap;
  final double minHeight;
  final bool isCenter;
  final Color? textColor;
  final Color? bgColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: enabled ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          constraints: BoxConstraints(minHeight: minHeight, minWidth: 88),
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Text(
            text,
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
            style: TextStyles.subtitleMedium(
              color: textColor ?? Palette.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
