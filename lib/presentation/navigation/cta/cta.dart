import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/app_routes.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta_external_screen.dart';
import 'package:ioc_demo/presentation/navigation/cta/cta_model.dart';
import 'package:ioc_demo/presentation/navigation/helpers/custom_route.dart';
import 'package:ioc_demo/utilities%20/utility.dart';

class CTARoutes {
  static final Map<String, AppRouteBuilder> _deepLinks =
      <String, AppRouteBuilder>{
    // "/screen3": (Map<String, String> parameters) {
    //   final String? param = parameters["param"];
    //   if (param != null && param.isNotEmpty) {
    //     return CommonRoutes.screen3(param: param);
    //   }
    //   return null;
    // },
    // "/screen2": (_) => CommonRoutes.screen2(),
  };

  static AppRoute<dynamic>? cta(CTAModel cta) {
    if (cta.type == CTAType.deepLink) {
      return _deepLink(cta);
    } else if (cta.type == CTAType.web || cta.type == CTAType.externalApp) {
      return _external(cta);
    }
    return null;
  }

  static AppRoute<dynamic> _external(CTAModel cta) {
    return AppRoute<dynamic>(
      'cta',
      routeBuilder: (BuildContext context, AppNavigator appNavigator) {
        return CustomRoute<dynamic>(
          appNavigator: appNavigator,
          builder: (_) => CTAExternalScreen(cta: cta),
        );
      },
    );
  }

  static AppRoute<dynamic>? _deepLink(CTAModel cta) {
    final Uri url = Uri.parse(cta.url);
    Utility.showLog('path: ${url.path}');
    Utility.showLog('parameters: ${url.queryParameters}');
    final AppRouteBuilder? routeBuilder = _deepLinks[url.path];
    if (routeBuilder != null) {
      return routeBuilder(url.queryParameters);
    }
    return null;
  }
}

typedef AppRouteBuilder = AppRoute<dynamic>? Function(
  Map<String, String> parameters,
);
