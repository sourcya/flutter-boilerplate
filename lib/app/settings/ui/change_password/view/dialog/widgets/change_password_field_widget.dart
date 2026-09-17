part of '../../../imports/change_password_imports.dart';

class ChangePasswordFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final RxBool hidePassword;
  final void Function(bool isValid)? onValidationChanged;
  final void Function(String?)? onChanged;
  final String? Function(String?) validator;
  final GlobalKey<FormState>? formKey;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final String? label;
  final bool isWideLayout;

  const ChangePasswordFieldWidget({
    super.key,
    required this.hint,
    required this.controller,
    required this.hidePassword,
    required this.onValidationChanged,
    required this.validator,
    this.onChanged,
    this.formKey,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.label,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    final field = _ChangePasswordTextField(
      hint: hint,
      controller: controller,
      hidePassword: hidePassword,
      onValidationChanged: onValidationChanged,
      onChanged: onChanged,
      validator: validator,
      formKey: formKey,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      isWideLayout: isWideLayout,
    );

    if (!isWideLayout || label == null) {
      return field;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _ChangePasswordFieldLabel(label: label ?? 'N/A'),
        4.0.hBox,
        field,
      ],
    );
  }
}

class _ChangePasswordTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final RxBool hidePassword;
  final void Function(bool isValid)? onValidationChanged;
  final void Function(String?)? onChanged;
  final String? Function(String?) validator;
  final GlobalKey<FormState>? formKey;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final bool isWideLayout;

  const _ChangePasswordTextField({
    required this.hint,
    required this.controller,
    required this.hidePassword,
    required this.onValidationChanged,
    required this.validator,
    this.onChanged,
    this.formKey,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    final wide = isWideLayout;

    return Obx(() {
      final obscured = hidePassword.value;

      return CustomTextField(
        formKey: formKey,
        hint: hint,
        obscureText: obscured,
        useNativeTextField: true,
        suffix: IconButton(
          padding: context.paddingSymmetric(vertical: 8.0, horizontal: 12.0),
          icon: Icon(
            obscured ? Icons.visibility_off : Icons.visibility,
            size: 20.r,
            color: context.colors.mutedForeground,
          ),
          onPressed: () {
            hidePassword.value = !hidePassword.value;
          },
        ),
        controller: controller,
        validator: validator,
        shouldAutoValidate: true,
        onValidationChanged: onValidationChanged,
        onChanged: onChanged == null ? null : (value) => onChanged!(value),
        textColor: wide ? context.colors.foreground : context.colors.onSurface,
        hintColor: context.colors.mutedForeground,
        borderColor: context.colors.inputBorderColor,
        focusedBorderColor: context.colors.primary,
        fillColor: wide ? context.colors.inputBackgroundColor : null,
        textInputAction: textInputAction,
        autoFillHints: autofillHints,
        contentPadding: context.paddingSymmetric(horizontal: 12.0, vertical: 10.0),
        borderRadius: wide ? BorderRadius.circular(12.r) : 9999.0.radius,
        inputTextStyle: wide
            ? context.bodyMediumTS.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.43,
                color: context.colors.foreground,
              )
            : null,
        hintStyle: wide
            ? context.bodyMediumTS.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.43,
                color: context.colors.mutedForeground,
              )
            : null,
      );
    });
  }
}

class _ChangePasswordFieldLabel extends StatelessWidget {
  const _ChangePasswordFieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${label.tr(context: context)} ',
            style: context.bodyMediumTS.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.43,
              color: context.colors.foreground,
            ),
          ),
          TextSpan(
            text: '*',
            style: context.bodyMediumTS.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.43,
              color: AppColors.semanticDestructive,
            ),
          ),
        ],
      ),
    );
  }
}
