import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.radius,
    this.borderWidth,
    this.alignment,
    this.border,
    this.isFullRoundCorner = false,
    this.borderRadius,
  }) : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? radius;
  final AlignmentGeometry? alignment;
  final BoxBorder? border;
  final bool isFullRoundCorner;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(
                isFullRoundCorner ? 1000 : radius ?? Spacings.custom5,
              ),
            ),
        border: border ??
            Border.all(
              color: borderColor ?? Palette.lightGreyColor,
              width: borderWidth ?? 1,
            ),
      ),
      clipBehavior: Clip.antiAlias,
      padding: padding,
      child: child,
    );
  }
}
