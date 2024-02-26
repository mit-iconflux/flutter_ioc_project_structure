import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/navigation/app_navigator.dart';
import 'package:ioc_demo/presentation/navigation/helpers/bottom_sheet_constants.dart';
import 'package:ioc_demo/presentation/navigation/widget/bottom_sheet_header_widget.dart';
import 'package:ioc_demo/presentation/navigation/widget/bottom_sheet_wrap_container.dart';
import 'package:ioc_demo/presentation/widgets/components/button_primary.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class CustomDialogBottomSheet extends StatelessWidget {
  const CustomDialogBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.onCallBack,
    this.isSingleButton = false,
    this.positiveButtonText = 'Ok',
    this.negativeButtonText = 'Cancel',
    this.heightTag = BottomSheetConstants.heightSmall,
  });

  final String title;
  final String message;
  final bool? isSingleButton;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final String? heightTag;
  final Function(int) onCallBack;

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapContainer(
      heightTag: heightTag ?? BottomSheetConstants.heightSmall,
      childScrollViewNeeded: true,
      child: Column(
        children: <Widget>[
          BottomSheetHeaderWidget(
            title: title,
          ),
          Expanded(
            child: TextLabel(
              text: message,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonPrimary(
                  text: positiveButtonText ?? 'Ok',
                  onTap: () {
                    AppNavigator().pop();
                    onCallBack(0);
                  },
                ),
              ),
              if (!(isSingleButton ?? false))
                const SizedBox(
                  width: Spacings.small,
                ),
              if (!(isSingleButton ?? false))
                Expanded(
                  child: ButtonPrimary(
                    text: negativeButtonText ?? 'Cancel',
                    onTap: () {
                      AppNavigator().pop();
                      onCallBack(1);
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
