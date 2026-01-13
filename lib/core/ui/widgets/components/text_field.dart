part of '../../ui.dart';

/// This is a custom text field to have same behavior on whole application.
/// With ability to auto validate it's field and easily customize it.
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
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final EdgeInsets? scrollPadding;

  final Iterable<String>? autoFillHints;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final void Function(String?)? onSubmitted;
  final Duration? debounceDuration;
  final bool debounceValidation;
  final BorderSide? enabledBorderSide;

  const CustomTextField({
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintStyle,
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
    this.padding,
    this.margin,
    this.errorMaxLines = 2,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderColor,
    this.focusedBorderColor,
    this.formKey,
    this.onValidationChanged,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.scrollPadding,
    this.autoFillHints,
    this.contentPadding,
    this.borderRadius,
    this.borderWidth,
    this.onSubmitted,
    this.debounceDuration,
    this.debounceValidation = false,
    this.enabledBorderSide,
  });

  @override
  Widget build(BuildContext context) {
    return OptimizedTextField(
      hint: hint?.tr(context: context),
      hintStyle: hintStyle ??
          TextStyle(
            fontSize: 13.sp,
            color: hintColor ?? const Color(0xFF707B81),
            fontFamily: fontFamily(context: context),
          ),
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onTap: onTap,
      icon: icon,
      type: type,
      validator: validator,
      controller: controller,
      focus: focus,
      nextFocus: nextFocus,
      scrollPadding: scrollPadding,
      autoFillHints: autoFillHints,
      onSubmitted: onSubmitted,
      prefix: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.0.r,
              ),
              child: Icon(
                prefixIcon,
                // color: context.colors.secondary,
                size: 20.r,
              ),
            )
          : prefix,
      suffix: suffixIcon != null
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.0.r,
              ),
              child: Icon(
                suffixIcon,
                // color: context.colors.secondary,
                size: 20.r,
              ),
            )
          : suffix,
      label: label?.tr(context: context),
      read: read,
      obscureText: obscureText,
      enabled: enabled,
      eIcon: eIcon,
      edit: edit,
      fillColor: fillColor,
      autofocus: autofocus,
      shouldAutoValidate: shouldAutoValidate,
      padding: padding ?? EdgeInsets.symmetric(vertical: 8.r),
      margin: margin,
      errorMaxLines: errorMaxLines,
      textColor: textColor,
      labelColor: labelColor ?? context.colors.onSurface,
      focusedBorderColor: focusedBorderColor,
      borderColor: borderColor,
      formKey: formKey,
      debounceDuration: debounceDuration,
      debounceValidation: debounceValidation,
      onValidationChanged: onValidationChanged,
      textInputAction: textInputAction,
      style: TextStyle(
        fontSize: Dimens.fieldTextSize,
        color: textColor ?? context.colors.onSurface,
        fontFamily: fontFamily(context: context),
      ),
      labelStyle: TextStyle(
        color: labelColor ?? context.colors.onSurface,
        fontSize: 15.sp,
        fontFamily: fontFamily(context: context),
      ),
      contentPadding: contentPadding ??
          EdgeInsets.only(
            top: 12.0.r,
            bottom: 12.0.r,
            right: 15.0.r,
            left: 15.0.r,
          ),
      hintColor: hintColor ?? PlayxColors.grey,
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? Style.fieldBorderRadius,
        borderSide: enabledBorderSide ??
            BorderSide(
                color: borderColor ?? const Color(0xFFC0C0C0),
                width: borderWidth ?? 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor ?? context.colors.primary,
          width: borderWidth ?? 1,
        ),
        borderRadius: borderRadius ?? Style.fieldBorderRadius,
      ),
      border: OutlineInputBorder(
        borderSide: enabledBorderSide ??
            BorderSide(
                color: borderColor ?? const Color(0xFFC0C0C0),
                width: borderWidth ?? 1),
        borderRadius: borderRadius ?? Style.fieldBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: borderWidth ?? 1),
        borderRadius: borderRadius ?? Style.fieldBorderRadius,
      ),
    );
  }
}
