import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/helpers/bottom_sheet_constants.dart';
import 'package:ioc_demo/presentation/navigation/widget/dialog_header_widget.dart';
import 'package:ioc_demo/presentation/navigation/widget/dialog_wrap_container.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onCallBack,
    this.isSingleButton = false,
    this.isHideTitle = false,
    this.positiveButtonText = 'Ok',
    this.negativeButtonText = 'Cancel',
    this.heightTag = BottomSheetConstants.heightSmall,
    this.bgColor,
    this.textColor,
  });

  final String title;
  final String message;
  final bool? isSingleButton;
  final bool isHideTitle;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final String? heightTag;
  final Function(int) onCallBack;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return DialogWrapContainer(
      backgroundColor: Palette.whiteColor,
      childScrollViewNeeded: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isHideTitle)
            DialogHeaderWidget(
              title: title,
            ),
          SizedBox(
            width: double.infinity,
            child: TextLabel(
              text: message,
              overflow: TextOverflow.visible,
              textStyle: TextStyles.normal(
                color: Palette.greyColor,
              ),
            ),
          ),
          const SizedBox(
            height: Spacings.xLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (!(isSingleButton ?? false))
                MaterialButton(
                  onPressed: () {
                    AppNavigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    negativeButtonText ?? 'Cancel',
                    style: TextStyles.normal(
                      color: textColor ?? Palette.primaryColor,
                    ),
                  ),
                ),
              if (!(isSingleButton ?? false))
                const SizedBox(
                  width: Spacings.small,
                ),
              MaterialButton(
                onPressed: () {
                  AppNavigator.of(context).pop();
                  onCallBack(0);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: bgColor ?? Palette.primaryColor,
                child: TextLabel(
                  text: positiveButtonText ?? 'Ok',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
