import 'package:flutter/material.dart';

class ImageAssets {
  static String imageEndPoint = 'assets/images/';
  static String iconEndPoint = 'assets/icons/';

  static String splashImagePath = '${imageEndPoint}splash_image.png';
  static String technicalErrorImagePath = '${imageEndPoint}error_view.png';
  static String noDataImagePath = '${imageEndPoint}no_data.png';
  static String noInternetPath = '${imageEndPoint}no_internet.png';

  static Image setImage({
    required String imagePath,
    BoxFit boxFit = BoxFit.contain,
    double? height,
    double? width,
    Color? iconColor,
  }) {
    return Image.asset(
      imagePath,
      fit: boxFit,
      height: height,
      width: width,
      color: iconColor,
    );
  }

  static Image splashImage({Color? color, double? width, double? height}) =>
      Image.asset(
        splashImagePath,
        color: color,
        width: width,
        height: height,
      );
}
