import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.size,
    this.style,
    this.textInputType,
    this.inputDecoration,
    this.focusedBorder,
    this.border,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.textInputAction,
    this.onEditingComplete,
    this.autovalidateMode,
    this.controller,
    this.focusNode,
    this.obscureText,
    this.enabled,
    this.inputFormatters,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.maxLines,
    this.autoFocus,
    this.textCapitalization,
    this.onTap,
    this.hintStyle,
    this.lableStyle,
    this.readOnly,
    this.suffixIcon,
    this.padding,
  }) : super(key: key);

  final Size? size;
  final TextStyle? style;
  final TextInputType? textInputType;
  final InputDecoration? inputDecoration;
  final InputBorder? focusedBorder;
  final InputBorder? border;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? obscureText;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? autoFocus;
  final TextCapitalization? textCapitalization;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final TextStyle? lableStyle;
  final EdgeInsets? padding;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: TextFormField(
        readOnly: readOnly ?? false,
        cursorColor: Colors.black,
        cursorRadius: const Radius.circular(5),
        cursorWidth: 1,
        cursorHeight: 20,
        style: style ?? const TextStyle(fontSize: 18),
        keyboardType: textInputType ?? TextInputType.text,
        decoration: inputDecoration ??
            InputDecoration(
              hintStyle: hintStyle ?? Theme.of(context).textTheme.subtitle1,
              labelStyle: lableStyle ??
                  hintStyle ??
                  Theme.of(context).textTheme.subtitle1,
              focusedBorder: focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.green[100]!, width: 2.0),
                  ),
              border: border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: labelText,
              hintText: hintText,
            ),
        textInputAction: textInputAction ?? TextInputAction.next,
        onEditingComplete: onEditingComplete,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        enabled: enabled,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        maxLines: maxLines ?? 1,
        autofocus: autoFocus ?? false,
        onTap: onTap,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      ),
    );
  }
}
