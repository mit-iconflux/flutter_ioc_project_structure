import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/circular_progress_bar.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';

import '../custom_switch.dart';

enum SelectionControlType { checkBox, radioButton, switchBox }

class SelectionControl extends StatelessWidget {
  const SelectionControl({
    Key? key,
    required this.title,
    required this.checked,
    this.enabled = true,
    this.isEnableChecked = false,
    this.onChanged,
    this.loadingColor,
    this.isLoading = false,
    this.type = SelectionControlType.checkBox,
    this.onCustomSwitchColor,
    // this is off switch round color
    this.offCustomSwitchColor,
    // this is on background color
    this.onBackgroundColor = Palette.lightGreyColor,
    // this is off card background
    this.offBackgroundColor = Palette.lightGreyColor,
    this.onTextStyle,
    this.offTextStyle,
    this.leading,
    this.offCheckBoxColor,
    this.padding,
  }) : super(key: key);
  static const BorderRadius _radius = BorderRadius.all(
    Radius.circular(Spacings.cardBorderRadius),
  );

  final Widget title;
  final bool checked;
  final bool enabled;
  final bool isEnableChecked;
  final ValueChanged<bool>? onChanged;
  final SelectionControlType type;
  final Color? onCustomSwitchColor;
  final Color? offCustomSwitchColor;
  final Color? onBackgroundColor;
  final Color? offBackgroundColor;
  final TextStyle? onTextStyle;
  final TextStyle? offTextStyle;
  final bool isLoading;
  final Color? loadingColor;
  final Widget? leading;
  final Color? offCheckBoxColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Color onSwitchColor = onCustomSwitchColor ?? Palette.primaryColor;
    final Color offSwitchColor = offCustomSwitchColor ?? Palette.lightGreyColor;

    final Widget? leadingIcon = type != SelectionControlType.switchBox
        ? _buildLeading(onSwitchColor)
        : leading;
    final Widget trailing = _buildTrailing(
      onSwitchColor: onSwitchColor,
      offSwitchColor: offSwitchColor,
    );
    return AnimatedContainer(
      //constraints: const BoxConstraints(minHeight: 50),
      decoration: const BoxDecoration(
        borderRadius: _radius,
      ),
      duration: const Duration(milliseconds: 100),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          customBorder: const RoundedRectangleBorder(borderRadius: _radius),
          onTap: isEnableChecked
              ? null
              : () => onChanged?.call(enabled ? !checked : checked),
          child: Padding(
            padding: padding ??
                const EdgeInsets.all(
                  Spacings.small,
                ),
            child: Center(
              child: Row(
                children: <Widget>[
                  if (leadingIcon != null)
                    InkWell(
                      onTap: () {
                        if (isEnableChecked) {
                          onChanged?.call(!checked);
                        } else {
                          onChanged?.call(enabled ? !checked : checked);
                        }
                      },
                      child: leadingIcon,
                    ),
                  const SizedBox(width: Spacings.small),
                  Expanded(
                    child: DefaultTextStyle.merge(
                      style: TextStyles.normal(
                        color: Palette.greyColor,
                      ),
                      child: title,
                    ),
                  ),
                  if (isLoading)
                    SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressBar(
                        color: loadingColor ?? Palette.primaryColor,
                        strokeWidth: 2,
                      ),
                    ),
                  const SizedBox(width: Spacings.small),
                  trailing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(Color onColor) {
    switch (type) {
      case SelectionControlType.checkBox:
        if (checked) {
          return Icon(
            Icons.check_box,
            color: onColor,
          );
        } else {
          return offCheckBoxColor != null
              ? Icon(Icons.check_box_outline_blank, color: offCheckBoxColor)
              : Icon(Icons.check_box_outline_blank);
        }
      case SelectionControlType.radioButton:
        if (checked) {
          return Icon(
            Icons.radio_button_checked,
            color: onColor,
          );
        } else {
          return offCheckBoxColor != null
              ? Icon(Icons.radio_button_off, color: offCheckBoxColor)
              : Icon(Icons.radio_button_off);
        }
      default:
        return const SizedBox();
    }
  }

  Widget _buildTrailing({
    required Color onSwitchColor,
    required Color offSwitchColor,
  }) {
    switch (type) {
      case SelectionControlType.switchBox:
        return CustomSwitch(
          checked: checked,
          enabled: enabled,
          offColor: offSwitchColor,
          onColor: onSwitchColor,
        );
      default:
        return const SizedBox();
    }
  }
}
