import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

class AppCardWidget extends StatelessWidget {
  const AppCardWidget({
    required this.child,
    this.radius = 7,
    this.padding,
    this.color = Palette.whiteColor,
    this.shadowColor = Palette.lightGreyColor,
    this.maxShadow = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double radius;
  final EdgeInsets? padding;
  final Color color;
  final Color shadowColor;
  final bool maxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: maxShadow ? shadowColor : shadowColor.withOpacity(0.3),
            spreadRadius: maxShadow ? 10 : 5,
            blurRadius: maxShadow ? 10 : 5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(Spacings.medium),
        child: child,
      ),
    );
  }
}
