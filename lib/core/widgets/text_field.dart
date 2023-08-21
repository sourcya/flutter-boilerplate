// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

/// This is a custom text field to have same behavior on whole application.
/// With ability to auto validate it's field and easily customize it.
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
  final FocusNode? nextFocus;
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
  final TextInputAction textInputAction;

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
    this.nextFocus,
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
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomFieldState();
  }
}

class _CustomFieldState extends State<CustomTextField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OptimizedTextField(
        hint: widget.hint,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        icon: widget.icon,
        type: widget.type,
        validator: widget.validator,
        controller: widget.controller,
        focus: widget.focus,
        nextFocus: widget.nextFocus,
        prefix: widget.prefix,
        suffix: widget.suffix,
        label: widget.label,
        read: widget.read,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        eIcon: widget.eIcon,
        edit: widget.edit,
        fillColor: widget.fillColor,
        autofocus: widget.autofocus,
        shouldAutoValidate: widget.shouldAutoValidate,
        padding: widget.padding,
        margin: widget.margin,
        errorMaxLines: widget.errorMaxLines,
        textColor: widget.textColor,
        labelColor: widget.labelColor ?? context.colorScheme.secondary,
        borderColor: widget.borderColor,
        focusedBorderColor: widget.focusedBorderColor,
        formKey: widget.formKey,
        onValidationChanged: widget.onValidationChanged,
        textInputAction: widget.textInputAction,
        style: TextStyle(
          fontSize: 16.sp,
          color: widget.textColor ?? context.colorScheme.onBackground,
        ),
      labelStyle: TextStyle(
        color: widget.labelColor ?? context.colorScheme.secondary,
        fontSize: 16.sp,
      ),
      contentPadding: EdgeInsets.only(
        top: 15.0.h,
        bottom: 15.0.h,
        right: 15.0.w,
        left: 15.0.w,
      ),
      hintColor:widget.hintColor ?? XColorScheme.grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: widget.borderColor ?? XColorScheme.grey,
          ),),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.focusedBorderColor ??
              context.colorScheme.secondary,
          // color: Colors.grey.withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      border: OutlineInputBorder(
        borderSide:
        BorderSide(color: widget.borderColor ?? XColorScheme.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
        const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
