import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class BottomSheetHeaderWidget extends StatelessWidget {
  const BottomSheetHeaderWidget({
    Key? key,
    required this.title,
    this.keyTitle,
    this.keyCloseButton,
    this.padding = EdgeInsets.zero,
    this.bottomPadding = true,
    this.titlePadding = 24,
    this.subTitleStyle,
    this.onCloseCallBack,
    this.isCloseButtonVisible = true,
  }) : super(key: key);

  final String title;
  final Key? keyTitle;
  final Key? keyCloseButton;
  final EdgeInsets padding;
  final double titlePadding;
  final bool? bottomPadding;
  final bool isCloseButtonVisible;
  final VoidCallback? onCloseCallBack;
  final TextStyle? subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: padding,
              child: isCloseButtonVisible
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        key: keyCloseButton,
                        onPressed: () {
                          if (onCloseCallBack != null) {
                            onCloseCallBack?.call();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.close),
                      ),
                    )
                  : const SizedBox(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Spacings.xxxxLarge),
              child: TextLabel(
                text: title,
                key: keyTitle,
                textStyle: TextStyles.subtitle(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Spacings.medium,
        ),
      ],
    );
  }
}
