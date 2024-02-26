import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';

Widget customCardView({
  BoxBorder? border,
  required Widget child,
  EdgeInsetsGeometry? padding,
  double spreadRadius = 1,
  double radius = 10.0,
  Color shadowColor = Palette.lightGreyColor,
  Color color = Palette.whiteColor,
  //double radius = 10.0,
  double blurRadius = 3,
  EdgeInsetsGeometry? margin,
}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color,
      border: border,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: shadowColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    ),
    child: child,
  );
}
