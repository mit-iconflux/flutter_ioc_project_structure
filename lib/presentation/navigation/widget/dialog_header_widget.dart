import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class DialogHeaderWidget extends StatelessWidget {
  const DialogHeaderWidget({
    Key? key,
    required this.title,
    this.keyTitle,
    this.keyCloseButton,
    this.padding = EdgeInsets.zero,
    this.bottomPadding = true,
    this.titlePadding = 24,
    this.subTitleStyle,
    this.onCloseCallBack,
    this.isCloseButtonVisible = false,
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
              padding: EdgeInsets.symmetric(
                horizontal: isCloseButtonVisible ? Spacings.xxxxLarge : 0,
              ),
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
