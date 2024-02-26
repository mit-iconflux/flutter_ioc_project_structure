import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/circular_progress_bar.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

/// RadioListTileWidget
class RadioListTileWidget<T> extends StatelessWidget {
  /// Constructor
  const RadioListTileWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.colorSelected,
    this.colorUnSelected,
    this.isLoading = false,
  }) : super(key: key);

  /// Label
  final String title;

  /// Value = Own value
  final T value;

  /// Group Value = Selected value
  final T groupValue;

  /// onChanged
  final ValueChanged<T> onChanged;

  /// colorSelected
  final Color? colorSelected;

  /// colorUnSelected
  final Color? colorUnSelected;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (value == groupValue)
                Icon(Icons.radio_button_checked)
              else
                Icon(Icons.radio_button_off),
              const SizedBox(width: 8.0),
              TextLabel(
                text: title,
                textStyle: TextStyles.normal(),
              ),
            ],
          ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(left: Spacings.medium),
              child: SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressBar(
                  color: colorSelected,
                  strokeWidth: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
