// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../resources/colors.dart';

class CustomTextField extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        type: MaterialType.transparency,
        child: TextFormField(
          enabled: enabled,
          onTap: onTap,
          validator: validator,
          controller: controller,
          focusNode: focus,
          readOnly: read,
          maxLines: maxLines,
          minLines: minLines,
          obscureText: obscureText,
          keyboardType: type,
          onChanged: onChanged,
          autofocus: autofocus,
          style: TextStyle(
            fontSize: 14,
            color: AppThemeConfig.getColorScheme(context).onBackground,
          ),
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: fillColor != null,
            labelStyle: TextStyle(
              color: AppThemeConfig.getColorScheme(context).secondary,
              fontSize: 14,
            ),
            hintText: hint,
            prefixIcon: prefix,
            labelText: label,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            icon: icon,
            suffixIcon: suffix,
            hintStyle: const TextStyle(color: AppColors.grey),
            floatingLabelStyle: TextStyle(
                color: AppThemeConfig.getColorScheme(context).secondary,
                fontSize: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppThemeConfig.getColorScheme(context).secondary,
                // color: Colors.grey.withOpacity(0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
