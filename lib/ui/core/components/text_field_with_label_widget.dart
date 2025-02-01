import 'package:basic_app/ui/core/components/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithLabelWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool? readOnly;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final int? maxLength;
  final bool? obrigatory;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final void Function()? onTap;
  final int? minLines;
  const TextFieldWithLabelWidget({
    super.key,
    this.controller,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.obrigatory,
    this.keyboardType,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.minLines,
    this.onSubmit,
  });

  @override
  State<TextFieldWithLabelWidget> createState() => _TextFieldWithLabelWidgetState();
}

class _TextFieldWithLabelWidgetState extends State<TextFieldWithLabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.labelText != null,
          child: Row(
            children: [
              SizedBox(
                width: 4,
              ),
              Text(
                (widget.obrigatory == true ? '* ' : '') + (widget.labelText ?? ''),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        TextFieldWidget(
          initialValue: widget.initialValue,
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          hintText: widget.hintText ?? '',
          sufixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          keyBoardType: widget.keyboardType,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmit,
          onTap: widget.onTap,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          minLines: widget.minLines,
        ),
      ],
    );
  }
}
