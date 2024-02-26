import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/helpers/custom_popup_route.dart';

class AppPage<T> extends MaterialPage<T> {
  const AppPage({
    required LocalKey key,
    required Widget child,
    bool maintainState = true,
  }) : super(
          key: key,
          child: child,
          maintainState: maintainState,
        );
}

class AppPopupPage<T> extends MaterialPage<T> {
  const AppPopupPage({
    required LocalKey key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  Route<T> createRoute(BuildContext context) {
    return CustomPopupRoute<T>(
      settings: this,
      widgetBuilder: (_) => child,
    );
  }
}
