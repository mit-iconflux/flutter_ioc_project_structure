import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget({
    required this.listItems,
    this.selectedValue,
    required this.onChange,
    this.isExpanded = false,
    this.hint,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.icon,
    this.label,
    Key? key,
  }) : super(key: key);
  final DropDownModel? selectedValue;
  final List<DropDownModel> listItems;
  final Function(DropDownModel) onChange;
  final bool isExpanded;
  final String? hint;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Widget? icon;
  final String? label;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  DropDownModel? selectedValue;
  List<DropDownModel> listItems = <DropDownModel>[];

  @override
  void initState() {
    super.initState();
    listItems = widget.listItems;
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null && widget.label != '')
          Column(
            children: <Widget>[
              TextLabel(
                text: widget.label!,
                textStyle: TextStyles.normalMedium(),
              ),
              const SizedBox(
                height: Spacings.cardBorderRadius,
              ),
            ],
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(Spacings.small),
            ),
            border: Border.all(color: Palette.lightGreyColor),
            color: widget.backgroundColor,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.medium,
          ),
          child: Row(
            children: <Widget>[
              if (widget.prefixIcon != null)
                Expanded(
                  child: widget.prefixIcon!,
                ),
              if (widget.prefixIcon != null)
                const SizedBox(
                  width: Spacings.small,
                ),
              Expanded(
                flex: 9,
                child: DropdownButton<DropDownModel>(
                  value: selectedValue,
                  isExpanded: widget.isExpanded,
                  hint: widget.hint != null
                      ? TextLabel(
                          text: widget.hint!,
                        )
                      : null,
                  style: TextStyles.normal(size: 12),
                  underline: const SizedBox(),
                  icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down),
                  items: listItems.map((DropDownModel model) {
                    return DropdownMenuItem<DropDownModel>(
                      value: model,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextLabel(
                            text: model.value,
                            textStyle: TextStyles.normal(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (DropDownModel? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                    widget.onChange(selectedValue!);
                  },
                ),
              ),
              if (widget.suffixIcon != null)
                const SizedBox(
                  width: Spacings.small,
                ),
              if (widget.suffixIcon != null)
                Expanded(
                  child: widget.suffixIcon!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropDownModel extends Equatable {
  const DropDownModel({
    required this.id,
    required this.value,
  });

  final String id;
  final String value;

  @override
  List<Object?> get props => <Object>[id, value];

  @override
  String toString() => value;
}
