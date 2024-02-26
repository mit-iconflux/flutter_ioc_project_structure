import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/font_constants.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';

class TextStyles {
  static TextStyle title({
    Color? color,
    FontWeight fontWeight = FontConstants.bold,
    double size = FontConstants.fontSizeLarge,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color ?? Palette.primaryColor,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle titleMedium({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.bold,
    double size = FontConstants.fontSizeNormal,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color ?? Palette.blackColor,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      );

  static TextStyle titleSmall({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.bold,
    double size = FontConstants.fontSizeSmall,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color ?? Palette.blackColor,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle normal({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.medium,
    double size = FontConstants.fontSizeNormal,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle normalMedium({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.regular,
    double size = FontConstants.fontSizeNormalMedium,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle normalSmall({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.regular,
    double size = FontConstants.fontSizeExtraSmall,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle subtitle({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.semiBold,
    double size = FontConstants.fontSizeNormal,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle subtitleMedium({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.semiBold,
    double size = FontConstants.fontSizeNormalMedium,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );

  static TextStyle subtitleSmall({
    Color? color = Palette.blackColor,
    FontWeight fontWeight = FontConstants.semiBold,
    double size = FontConstants.fontSizeExtraSmall,
    TextDecoration? decoration,
    String? fontFamily,
  }) =>
      TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: fontFamily,
      );
}
