import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ioc_demo/presentation/themes/palette.dart';
import 'package:ioc_demo/presentation/themes/text_styles.dart';
import 'package:ioc_demo/presentation/widgets/components/spacings.dart';
import 'package:ioc_demo/presentation/widgets/components/text_label.dart';

class TextEditField extends StatefulWidget {
  const TextEditField({
    Key? key,
    required this.context,
    this.autoFocus = false,
    this.hintText = '',
    required this.controller,
    this.textInputType = TextInputType.text,
    this.text,
    this.enabled = true,
    this.currentFocusNode,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.next,
    this.isObscureText = false,
    this.textInputFormatter,
    this.funOnChanged,
    this.fillColor,
    this.outlineBorderColor = Palette.lightGreyColor,
    this.outlineBorderColorFocused,
    this.outlineBorderWidth = 1,
    this.hintStyle,
    this.textStyle,
    this.readOnly = false,
    this.maxLength,
    this.onSubmitted,
    this.textLabel,
    this.validator,
    this.suffixTextWidget,
    this.prefixTextWidget,
    this.minLines,
    this.maxLines,
    this.counterText = '',
    this.enabledInputBorder,
    this.borderRadius = Spacings.small,
    this.autocorrect = false,
    this.hideTextLabel = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: Spacings.small,
      horizontal: Spacings.custom20,
    ),
    this.isRequired = false,
    required this.label,
    this.onEditingComplete,
  }) : super(key: key);

  final BuildContext context;

  final String? hintText;

  final String? text;

  final bool? enabled;
  final bool autoFocus;

  final bool? isObscureText;

  final TextInputType? textInputType;

  final TextEditingController? controller;

  final TextInputAction? textInputAction;

  final FocusNode? currentFocusNode;

  final FocusNode? nextFocusNode;

  final List<TextInputFormatter>? textInputFormatter;

  final Function(String)? funOnChanged;
  final int? maxLength;

  final Color? fillColor;
  final Color outlineBorderColor;
  final Color? outlineBorderColorFocused;
  final double outlineBorderWidth;

  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  final bool readOnly;
  final ValueChanged<String>? onSubmitted;
  final String? textLabel;
  final FormFieldValidator<String>? validator;

  final Widget? suffixTextWidget;
  final Widget? prefixTextWidget;

  final int? minLines;
  final int? maxLines;
  final String? counterText;
  final InputBorder? enabledInputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool autocorrect;
  final String label;
  final bool hideTextLabel;
  final Function()? onEditingComplete;
  final bool isRequired;

  @override
  TextEditFieldState createState() => TextEditFieldState();
}

class TextEditFieldState extends State<TextEditField> {
  @override
  void initState() {
    super.initState();
    if (widget.text != null) {
      widget.controller!.text = widget.text!;
    }
  }

  @override
  void didUpdateWidget(TextEditField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      widget.controller!.text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != '' && !widget.hideTextLabel)
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextLabel(
                      text: widget.label,
                    ),
                  ),
                  const SizedBox(
                    width: Spacings.tiny,
                  ),
                  if (widget.isRequired)
                    TextLabel(
                      text: '*',
                      textStyle: TextStyles.normal(
                        color: Palette.toastError,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: Spacings.cardBorderRadius,
              ),
            ],
          ),
        TextFormField(
          inputFormatters: widget.textInputFormatter,
          textInputAction: widget.textInputAction,
          cursorColor: Palette.greyColor,
          obscureText: widget.isObscureText!,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          enabled: widget.enabled,
          autofocus: widget.autoFocus,
          readOnly: widget.readOnly,
          focusNode: widget.currentFocusNode,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          autocorrect: widget.autocorrect,
          validator: widget.validator,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: (String value) {
            widget.onSubmitted?.call(value);
          },
          decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            counterText: widget.counterText,
            border: widget.enabledInputBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.outlineBorderColor,
                    width: widget.outlineBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.outlineBorderColorFocused ?? Palette.primaryColor,
                width: widget.outlineBorderWidth,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            prefixIcon: widget.prefixTextWidget != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[widget.prefixTextWidget!],
                  )
                : null,
            suffixIcon: widget.suffixTextWidget != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.suffixTextWidget!,
                    ],
                  )
                : null,
            fillColor: widget.fillColor,
            hintText: widget.hintText,
            enabledBorder: widget.enabledInputBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.outlineBorderColor,
                    width: widget.outlineBorderWidth,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
          ),
          onChanged: (String value) {
            if (widget.funOnChanged != null && widget.funOnChanged != null) {
              widget.funOnChanged!(value);
            }
          },
        ),
      ],
    );
  }
}
