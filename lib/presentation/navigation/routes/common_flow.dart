import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/app_routes.dart';
import 'package:ioc_demo/presentation/navigation/helpers/custom_route.dart';
import 'package:ioc_demo/presentation/widgets/custom_dialog.dart';

abstract class CommonFlow {
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
  }) {
    return AppRoute<dynamic>(
      'common:customDialog',
      routeBuilder: (BuildContext context, AppNavigator appNavigator) {
        return CustomRoute<dynamic>(
          alertDialog: true,
          appNavigator: appNavigator,
          builder: (_) => CustomDialog(
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
          ),
        );
      },
    );
  }

// static AppRoute<dynamic> assetListingScreen() => AppRoute<dynamic>(
//       'common:assetListingScreen',
//       routeBuilder: (BuildContext context, AppNavigator appNavigator) {
//         return CustomRoute<dynamic>(
//           appNavigator: appNavigator,
//           builder: (_) => const AssetListingScreen(),
//         );
//       },
//     );
}
