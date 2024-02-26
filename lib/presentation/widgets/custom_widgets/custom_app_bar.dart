import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

@override
AppBar customAppBar({
  required BuildContext context,
  Color? backgroundColor,
  bool isShowBackButton = false,
  String? title = '',
  List<Widget>? actionWidgets,
  Widget? leftActionWidget,
  Function()? backButtonFunction,
  bool isHtmlFormTitle = false,
  bool isCenterTitle = false,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Palette.primaryColor,
    centerTitle: isCenterTitle,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextLabel(
        text: title ?? '',
        textStyle: TextStyles.normal(color: Palette.whiteColor),
      ),
    ),
    leading: isShowBackButton
        ? IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.arrow_back,
                size: 15,
              ),
            ),
            onPressed: () {
              if (backButtonFunction == null) {
                //hideKeyBoard();
                Navigator.pop(context);
              } else {
                backButtonFunction();
              }
            },
          )
        : leftActionWidget,
    automaticallyImplyLeading: false,
    actions: actionWidgets,
  );
}
