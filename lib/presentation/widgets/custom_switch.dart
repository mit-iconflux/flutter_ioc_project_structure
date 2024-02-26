import 'package:flutter/material.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key? key,
    required this.checked,
    this.enabled = true,
    this.onColor,
    this.offColor,
  }) : super(key: key);
  final bool checked;
  final bool enabled;
  final Color? onColor;
  final Color? offColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 18,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: checked ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            width: 15,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: checked
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
              border: Border.all(
                color:
                    checked ? Palette.lightGreyColor : Palette.lightGreyColor,
              ),
              color: checked ? Palette.lightGreyColor : Palette.lightGreyColor,
            ),
          ),
        ),
        Align(
          alignment: checked ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: enabled
                  ? checked
                      ? onColor
                      : offColor
                  : Palette.lightGreyColor,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
