import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class BottomSheetConstants {
  static const String heightMedium = 'height_medium';
  static const String heightSmall = 'height_small';
  static const String heightFull = 'height_full';

  static double getHeight(String heightTag, BuildContext context) {
    const double bottomSheetHeightForHalf = 0.60;
    const double bottomSheetHeightForLow = 0.40;
    if (heightTag == heightFull) {
      return MediaQuery.of(context).size.height;
    } else if (heightTag == heightMedium) {
      return MediaQuery.of(context).size.height * bottomSheetHeightForHalf;
    } else if (heightTag == heightSmall) {
      return MediaQuery.of(context).size.height * bottomSheetHeightForLow;
    } else {
      return MediaQuery.of(context).size.height;
    }
  }
}
