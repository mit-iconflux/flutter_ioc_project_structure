import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/helpers/bottom_sheet_constants.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

class BottomSheetWrapContainer extends StatelessWidget {
  const BottomSheetWrapContainer({
    Key? key,
    required this.child,
    this.heightTag = BottomSheetConstants.heightFull,
    this.padding = const EdgeInsets.only(
      bottom: 16,
      left: 16,
      right: 16,
      top: 24,
    ),
    this.childScrollViewNeeded = false,
    this.backgroundColor,
    this.removeHeight = false,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final bool childScrollViewNeeded;
  final String heightTag;
  final Color? backgroundColor;
  final bool removeHeight;

  @override
  Widget build(BuildContext context) {
    return childScrollViewNeeded
        ? withoutScrollView(heightTag, context)
        : withScrollView(heightTag, context);
  }

  Widget withoutScrollView(String heightTag, BuildContext context) {
    return Container(
      height: removeHeight
          ? null
          : BottomSheetConstants.getHeight(heightTag, context),
      padding: const EdgeInsets.only(bottom: Spacings.medium),
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  Widget withScrollView(String heightTag, BuildContext context) {
    return Container(
      height: removeHeight
          ? null
          : BottomSheetConstants.getHeight(heightTag, context),
      padding: const EdgeInsets.only(bottom: Spacings.medium),
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
