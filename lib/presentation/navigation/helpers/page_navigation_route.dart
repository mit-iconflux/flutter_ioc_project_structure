import 'package:flutter/material.dart';

class PageNavigationRoute<T> extends PageRouteBuilder<T> {
  PageNavigationRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: animation.drive(CurveTween(curve: Curves.easeIn)).drive(
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ),
                ),
            child: child,
          ),
        );
  final Widget page;
}
