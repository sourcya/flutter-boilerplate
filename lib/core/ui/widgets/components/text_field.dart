part of '../../ui.dart';

/// App-wide text field wrapping [OptimizedTextField] with shared styling.
///
/// When [useNativeTextField] is true, uses [TextFormField] so prefix/suffix
/// icons, focus, and validation callbacks behave like the rest of the app.
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
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final EdgeInsets? scrollPadding;

  final Iterable<String>? autoFillHints;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final void Function(String?)? onSubmitted;
  final Duration? debounceDuration;
  final bool debounceValidation;
  final bool useNativeTextField;

  const CustomTextField({
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.hintStyle,
    this.inputTextStyle,
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
    this.errorMaxLines = 1,
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
    this.useNativeTextField = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final GlobalKey<FormState> _formKey;
  bool _isFieldValid = true;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
  }

  void _notifyValidationChanged() {
    if (!widget.shouldAutoValidate || widget.onValidationChanged == null) {
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (_isFieldValid != isValid) {
      widget.onValidationChanged!(isValid);
      _isFieldValid = isValid;
    }
  }

  OutlineInputBorder _inputBorder(Color color, BorderRadius borderRadius) {
    return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: color, width: widget.borderWidth ?? 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefixWidget = widget.prefixIcon != null
        ? Padding(
            padding: context.paddingSymmetric(horizontal: 8.0),
            child: Icon(
              widget.prefixIcon,
              size: 20.r,
            ),
          )
        : widget.prefix;
    final suffixWidget = widget.suffixIcon != null
        ? Padding(
            padding: context.paddingSymmetric(horizontal: 8.0),
            child: Icon(
              widget.suffixIcon,
              size: 20.r,
            ),
          )
        : widget.suffix;

    final borderRadius = widget.borderRadius ?? Style.fieldBorderRadius;
    final enabledBorder = _inputBorder(
      widget.borderColor ?? PlayxColors.grey,
      borderRadius,
    );
    final focusedBorder = _inputBorder(
      widget.focusedBorderColor ?? PlayxColors.grey,
      borderRadius,
    );
    final errorBorder = _inputBorder(context.colors.error, borderRadius);
    final hintStyle = widget.hintStyle ??
        TextStyle(
          fontSize: 13.sp,
          color: widget.hintColor ?? PlayxColors.grey,
          fontFamily: fontFamily(context: context),
        );
    final inputStyle = widget.inputTextStyle ??
        TextStyle(
          fontSize: Dimens.fieldTextSize,
          color: widget.textColor ?? context.colors.onSurface,
          fontFamily: fontFamily(context: context),
        );
    final contentPadding = (widget.contentPadding ??
            context.paddingOnly(top: 15.0, bottom: 15.0, end: 15.0, start: 15.0))
        .resolve(Directionality.of(context));

    if (widget.useNativeTextField) {
      final formField = Form(
        key: _formKey,
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focus,
          readOnly: widget.read,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          obscureText: widget.obscureText,
          keyboardType: widget.type,
          autofillHints: widget.autoFillHints,
          scrollPadding:
              (widget.scrollPadding ?? context.paddingSymmetric(vertical: 20))
                  .resolve(Directionality.of(context)),
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          autovalidateMode: widget.shouldAutoValidate
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          onTap: widget.onTap,
          onChanged: (value) {
            widget.onChanged?.call(value);
            _notifyValidationChanged();
          },
          onFieldSubmitted: (value) {
            widget.nextFocus?.requestFocus();
            widget.onSubmitted?.call(value);
          },
          style: inputStyle,
          decoration: InputDecoration(
            hintText: widget.hint?.tr(context: context),
            hintStyle: hintStyle,
            filled: widget.fillColor != null,
            fillColor: widget.fillColor,
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
            prefixIconConstraints: const BoxConstraints(),
            suffixIconConstraints: const BoxConstraints(),
            contentPadding: contentPadding,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            border: enabledBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            errorMaxLines: widget.errorMaxLines,
          ),
        ),
      );

      return Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: Padding(
          padding: widget.padding ?? context.paddingSymmetric(vertical: 8),
          child: formField,
        ),
      );
    }

    return OptimizedTextField(
      hint: widget.hint?.tr(context: context),
      hintStyle: hintStyle,
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
      scrollPadding: widget.scrollPadding,
      autoFillHints: widget.autoFillHints,
      onSubmitted: widget.onSubmitted,
      prefix: prefixWidget,
      suffix: suffixWidget,
      label: widget.label?.tr(context: context),
      read: widget.read,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      eIcon: widget.eIcon,
      edit: widget.edit,
      fillColor: widget.fillColor,
      autofocus: widget.autofocus,
      shouldAutoValidate: widget.shouldAutoValidate,
      padding: widget.padding ?? context.paddingSymmetric(vertical: 8),
      margin: widget.margin,
      errorMaxLines: widget.errorMaxLines,
      textColor: widget.textColor,
      labelColor: widget.labelColor ?? context.colors.onSurface,
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      formKey: _formKey,
      debounceDuration: widget.debounceDuration,
      debounceValidation: widget.debounceValidation,
      onValidationChanged: widget.onValidationChanged,
      textInputAction: widget.textInputAction,
      style: inputStyle,
      labelStyle: TextStyle(
        color: widget.labelColor ?? context.colors.onSurface,
        fontSize: Dimens.fieldTextSize,
        fontFamily: fontFamily(context: context),
      ),
      contentPadding: contentPadding,
      hintColor: widget.hintColor ?? PlayxColors.grey,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      border: enabledBorder,
      errorBorder: errorBorder,
    );
  }
}
