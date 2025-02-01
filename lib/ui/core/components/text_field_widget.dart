import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool allowPaddingOnLabelText;
  final bool enable;
  final bool obrigatory;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Widget? sufixIconLoading;
  final bool passwordField;
  final bool hideButtonShowPassword;
  final Color? colorLabelText;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final Color? backgroundColor;
  final double? circularBorder;
  final Color? fontColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final TextAlign textAlign;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? countLenghtText;
  final String? suffixText;
  final FocusNode? focusNode;
  final String? errorText;
  final TextInputAction? textInputAction;
  final int? errorMaxLines;
  final bool expands;
  final bool allowPaddingOnHintText;

  const TextFieldWidget({
    this.fontColor,
    this.labelText = '',
    this.hintText = '',
    this.allowPaddingOnLabelText = false,
    this.enable = true,
    this.colorLabelText,
    this.prefixIcon,
    this.sufixIcon,
    this.sufixIconLoading,
    this.passwordField = false,
    this.hideButtonShowPassword = false,
    this.onTap,
    this.controller,
    this.keyBoardType,
    this.onSaved,
    this.initialValue,
    this.validator,
    this.backgroundColor,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.countLenghtText,
    this.suffixText,
    this.focusNode,
    this.errorText,
    this.textInputAction,
    this.errorMaxLines,
    this.circularBorder,
    this.expands = false,
    super.key,
    this.allowPaddingOnHintText = false,
    this.obrigatory = false,
    this.contentPadding,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _passwordVisible = false;
  final double _defaultPaddingValue = 8;

  @override
  Widget build(BuildContext context) {
    if (widget.passwordField != false && widget.sufixIcon != null) {
      throw ('Não se pode ter um password field e um sufix icons. Escolha apenas um');
    }

    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
      expands: widget.expands,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      focusNode: widget.focusNode,
      minLines: widget.minLines,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      key: widget.key,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: widget.validator,
      keyboardType: widget.keyBoardType ?? TextInputType.text,
      controller: widget.controller,
      obscureText: widget.passwordField != false ? !_passwordVisible : false,
      style: const TextStyle(
        // color: widget.fontColor ?? CoresProjeto.preto,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        isDense: true,
        fillColor: Theme.of(context).colorScheme.surface,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.colorLabelText ?? Theme.of(context).colorScheme.outline,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        suffixText: widget.suffixText,
        counterText: widget.countLenghtText,
        enabled: widget.enable,
        filled: true,
        //fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
        iconColor: Theme.of(context).colorScheme.primary,
        contentPadding: widget.contentPadding,
        label: Padding(
          padding: EdgeInsets.only(
            left: widget.allowPaddingOnLabelText != false ? _defaultPaddingValue : 0,
            right: widget.allowPaddingOnLabelText != false ? _defaultPaddingValue : 0,
          ),
          child: Stack(
            children: [
              Text(
                (widget.obrigatory ? '* ' : '') + widget.labelText,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
        prefixIcon: widget.prefixIcon,
        suffix: widget.sufixIconLoading,
        suffixIcon: widget.passwordField && widget.hideButtonShowPassword == false
            ? IconButton(
                icon: _passwordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : widget.sufixIcon,
        errorText: widget.errorText,
        errorMaxLines: widget.errorMaxLines ?? 1,
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0, height: 0),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(widget.circularBorder ?? _defaultPaddingValue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(widget.circularBorder ?? _defaultPaddingValue),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(widget.circularBorder ?? _defaultPaddingValue),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(widget.circularBorder ?? _defaultPaddingValue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(widget.circularBorder ?? _defaultPaddingValue),
          //  borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
