import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    Key? key,
    required this.text,
    this.onTap,
    this.trailing,
    this.bgColor,
    this.textColor,
    this.enabled = true,
  }) : super(key: key);
  final String text;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool enabled;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Spacings.xxxLarge,
      child: MaterialButton(
        onPressed: enabled
            ? () {
                onTap!();
              }
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minWidth: MediaQuery.of(context).size.width,
        color: bgColor ?? Palette.primaryColor,
        disabledElevation: 0.5,
        disabledColor: Palette.greyColor,
        elevation: 2,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextWidget(),
            if (trailing != null) _buildTrailingWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextWidget() {
    return Flexible(
      child: TextLabel(
        text: text,
        textStyle: TextStyles.subtitleMedium(),
      ),
    );
  }

  Widget _buildTrailingWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
        left: 16,
      ),
      child: trailing,
    );
  }
}
