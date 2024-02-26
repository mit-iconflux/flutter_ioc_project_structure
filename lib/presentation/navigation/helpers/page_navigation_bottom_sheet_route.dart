import 'package:flutter/material.dart';

class PageNavigationBottomSheetRoute<T> extends PageRouteBuilder<T> {
  PageNavigationBottomSheetRoute({
    required this.page,
    this.shouldSwipeToCloseWidget = true,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: const Duration(milliseconds: 350),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          barrierColor: Colors.black.withAlpha(0x4c),
          opaque: false,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: animation.drive(CurveTween(curve: Curves.easeIn)).drive(
                  Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
                ),
            child: SafeArea(
              bottom: false,
              child: Container(
                alignment: Alignment.bottomCenter,
                // padding: const EdgeInsets.only(
                //   left: Spacings.medium,
                //   right: Spacings.medium,
                //   top: Spacings.small,
                // ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Material(
                    color: Colors.grey,
                    child: SafeArea(
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

  final Widget page;
  final bool shouldSwipeToCloseWidget;
}
