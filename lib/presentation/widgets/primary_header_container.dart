import 'package:flutter/material.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    Key? key,
    required this.child,
    this.height,
    this.gradientColor,
    this.color,
  }) : super(key: key);
  final double? height;
  final Widget child;
  final List<Color>? gradientColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: color,
      child: child,
    );
  }
}
