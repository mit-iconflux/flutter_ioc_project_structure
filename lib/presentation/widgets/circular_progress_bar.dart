import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({
    Key? key,
    this.widgetKey,
    this.color,
    this.strokeWidth = 3,
  }) : super(key: key);

  final Key? widgetKey;

  final Color? color;

  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      key: widgetKey,
      valueColor: AlwaysStoppedAnimation<Color>(color ?? Palette.primaryColor),
      strokeWidth: strokeWidth,
    );
  }
}
