import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta_model.dart';
import 'package:ioc_demo/presentation/navigation/routes/common_flow.dart';

abstract class AppRoutes {
  static AppRoute<dynamic>? cta(CTAModel cta) => CTARoutes.cta(cta);

  static AppRoute<dynamic> customDialog({
    required String title,
    required String message,
    required Function(int) onCallBack,
    bool? isSingleButton,
    bool isHideTitle = false,
    String? positiveButtonText,
    String? negativeButtonText,
    String? heightTag,
    Color? bgColor,
    Color? textColor,
  }) =>
      CommonFlow.customDialog(
        title: title,
        message: message,
        onCallBack: onCallBack,
        heightTag: heightTag,
        isSingleButton: isSingleButton,
        isHideTitle: isHideTitle,
        negativeButtonText: negativeButtonText,
        positiveButtonText: positiveButtonText,
        bgColor: bgColor,
        textColor: textColor,
      );
}

class AppRoute<T> {
  const AppRoute(this.name, {this.routeBuilder});

  final String name;
  final Route<T>? Function(
    BuildContext context,
    AppNavigator navigator,
  )? routeBuilder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRoute &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
