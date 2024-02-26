import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:provider/provider.dart';

class CustomRoute<T> extends PopupRoute<T> {
  CustomRoute({
    required this.builder,
    this.appNavigator,
    this.isProvider = true,
    this.alertDialog = false,
    this.isBarrierDismissible = true,
  });

  final WidgetBuilder builder;
  final AppNavigator? appNavigator;
  final bool? isProvider;
  final bool alertDialog;
  final bool isBarrierDismissible;

  @override
  Color? get barrierColor => null;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => isBarrierDismissible;

  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  AnimationController createAnimationController() {
    return AnimationController(
      duration: transitionDuration,
      debugLabel: 'CustomPopupRoute',
      vsync: navigator!.overlay!,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (alertDialog) {
      return FadeTransition(
        opacity: animation,
        child: getChild(child, context),
      );
    } else {
      return SlideTransition(
        position: animation.drive(CurveTween(curve: Curves.easeIn)).drive(
              Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
            ),
        child: getChild(child, context),
      );
    }
  }

  Widget getChild(Widget child, BuildContext context) {
    return alertDialog
        ? GestureDetector(
            onTap: () {
              if (barrierDismissible) {
                AppNavigator().pop();
              }
            },
            child: Container(
              color: Palette.greyColor.withOpacity(0.5),
              child: GestureDetector(
                onTap: () {},
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Spacings.small),
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  content: isProvider!
                      ? Provider<AppNavigator>.value(
                          value: appNavigator!,
                          child: child,
                        )
                      : child,
                ),
              ),
            ),
          )
        : isProvider!
            ? Provider<AppNavigator>.value(
                value: appNavigator!,
                child: child,
              )
            : child;
  }
}
