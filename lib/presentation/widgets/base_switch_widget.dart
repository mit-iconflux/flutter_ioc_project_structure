import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/widgets/components/selection_control.dart';

class BaseSwitchWidget extends StatefulWidget {
  const BaseSwitchWidget({
    Key? key,
    required this.initialChecked,
    required this.title,
    this.onValueChanged,
    this.enabled = true,
    this.leading,
    this.isLoading = false,
  }) : super(key: key);

  final bool initialChecked;
  final String title;
  final ValueChanged<bool>? onValueChanged;
  final bool enabled;
  final Widget? leading;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() => _BaseSwitchWidgetState();
}

class _BaseSwitchWidgetState extends State<BaseSwitchWidget> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialChecked;
  }

  @override
  Widget build(BuildContext context) {
    return SelectionControl(
      title: Text(widget.title),
      isLoading: widget.isLoading,
      type: SelectionControlType.switchBox,
      checked: _checked,
      leading: widget.leading,
      enabled: widget.enabled,
      onChanged: (bool checked) {
        _updateCheckedState(checked);
      },
    );
  }

  void _updateCheckedState(bool value) {
    if (_checked != value) {
      setState(() {
        _checked = value;
        if (widget.onValueChanged != null && widget.onValueChanged != null) {
          widget.onValueChanged!(_checked);
        }
      });
    }
  }
}
