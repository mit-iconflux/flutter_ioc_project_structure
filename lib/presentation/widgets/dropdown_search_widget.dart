import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/drop_down_button_widget.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class DropdownSearchWidget extends StatelessWidget {
  const DropdownSearchWidget({
    super.key,
    required this.list,
    required this.onChange,
    this.hint,
    this.label,
  });

  final List<DropDownModel> list;
  final Function(DropDownModel) onChange;
  final String? hint;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null && label != '')
          Column(
            children: <Widget>[
              TextLabel(
                text: label!,
                textStyle: TextStyles.subtitleMedium(),
              ),
              const SizedBox(
                height: Spacings.cardBorderRadius,
              ),
            ],
          ),
        DropdownSearch<DropDownModel>(
          popupProps: PopupProps<DropDownModel>.menu(
            showSearchBox: true,
            searchDelay: Duration.zero,
            itemBuilder: (
              BuildContext context,
              DropDownModel item,
              bool val,
            ) {
              return ListTile(
                title: TextLabel(text: item.value),
              );
            },
          ),
          compareFn: (DropDownModel item, DropDownModel sItem) {
            return item.id == sItem.id;
          },
          items: list,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGreyColor,
                ),
                borderRadius: BorderRadius.circular(Spacings.small),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGreyColor,
                ),
                borderRadius: BorderRadius.circular(Spacings.small),
              ),
              hintText: hint,
              hintStyle: TextStyles.normalMedium(
                color: Palette.colorTextFieldHint,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGreyColor,
                ),
                borderRadius: BorderRadius.circular(Spacings.small),
              ),
            ),
          ),
          onChanged: (DropDownModel? model) {
            if (model != null) {
              onChange(model);
            }
          },
        ),
      ],
    );
  }
}
