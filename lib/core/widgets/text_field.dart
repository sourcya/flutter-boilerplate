// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../resources/colors.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final TextInputType? type;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final IconData? eIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? icon;
  final FocusNode? focus;
  final bool read;
  final Function? edit;
  final int maxLines;
  final int minLines;
  final bool enabled;
  final bool obscureText;
  final Color? fillColor;
  final bool autofocus;
  final GlobalKey<FormState>? formKey;
  final bool shouldAutoValidate;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final int? errorMaxLines;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final void Function(bool isValid)? onValidationChanged;

  const CustomTextField({
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.onTap,
    this.icon,
    this.type,
    this.validator,
    this.controller,
    this.focus,
    this.prefix,
    this.suffix,
    this.label,
    this.read = false,
    this.obscureText = false,
    this.enabled = true,
    this.eIcon,
    this.edit,
    this.fillColor,
    this.autofocus = false,
    this.shouldAutoValidate = false,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.margin,
    this.errorMaxLines = 1,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor,
    this.focusedBorderColor,
    this.formKey,
    this.onValidationChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomFieldState();
  }
}

class _CustomFieldState extends State<CustomTextField> {
  GlobalKey<FormState>? formKey;
  bool? _isFieldValid;

  @override
  void initState() {
    formKey = widget.formKey ??
        (widget.shouldAutoValidate ? GlobalKey<FormState>() : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: Material(
        type: MaterialType.transparency,
        child: Form(
          key: formKey,
          child: TextFormField(
            enabled: widget.enabled,
            onTap: widget.onTap,
            validator: widget.validator,
            controller: widget.controller,
            focusNode: widget.focus,
            readOnly: widget.read,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            obscureText: widget.obscureText,
            keyboardType: widget.type,
            onChanged: (String input) {
              // ignore: prefer_null_aware_method_calls
              if (widget.onChanged != null) widget.onChanged!(input);

              if (widget.shouldAutoValidate) {
                if (formKey != null) {
                  final formState = formKey!.currentState;
                  final isValid = formState != null && formState.validate();
                  if (widget.onValidationChanged != null) {
                    if (_isFieldValid != isValid) {
                      widget.onValidationChanged!(isValid);
                      _isFieldValid = isValid;
                    }
                  }
                }
              }
            },
            autofocus: widget.autofocus,
            style: TextStyle(
              fontSize: 14,
              color: widget.textColor ??
                  AppThemeConfig.getColorScheme(context).onBackground,
            ),
            decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              labelStyle: TextStyle(
                color: widget.labelColor ??
                    AppThemeConfig.getColorScheme(context).secondary,
                fontSize: 14,
              ),
              hintText: widget.hint,
              prefixIcon: widget.prefix,
              labelText: widget.label,
              contentPadding: const EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
                right: 5.0,
                left: 15.0,
              ),
              icon: widget.icon,
              suffixIcon: widget.suffix,
              hintStyle: TextStyle(color: widget.hintColor ?? AppColors.grey),
              floatingLabelStyle: TextStyle(
                  color: widget.labelColor ??
                      AppThemeConfig.getColorScheme(context).secondary,
                  fontSize: 18),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ??
                      AppThemeConfig.getColorScheme(context).secondary,
                  // color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: widget.borderColor ?? AppColors.grey),
                borderRadius: BorderRadius.circular(24),
              ),
              errorMaxLines: widget.errorMaxLines,
            ),
          ),
        ),
      ),
    );
  }
}
