import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/helpers/bottom_sheet_constants.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

class DialogWrapContainer extends StatelessWidget {
  const DialogWrapContainer({
    Key? key,
    required this.child,
    this.heightTag = BottomSheetConstants.heightFull,
    this.padding = const EdgeInsets.all(
      Spacings.large,
    ),
    this.childScrollViewNeeded = false,
    this.backgroundColor,
    this.width,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final bool childScrollViewNeeded;
  final String? heightTag;
  final Color? backgroundColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return childScrollViewNeeded
        ? withoutScrollView(heightTag, context)
        : withScrollView(heightTag, context);
  }

  Widget withoutScrollView(String? heightTag, BuildContext context) {
    return Container(
      height: heightTag != null
          ? null
          : BottomSheetConstants.getHeight(heightTag!, context),
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Spacings.small),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  Widget withScrollView(String? heightTag, BuildContext context) {
    return Container(
      height: heightTag != null
          ? null
          : BottomSheetConstants.getHeight(heightTag!, context),
      width: width ?? MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
