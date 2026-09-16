part of '../../imports/forget_password_imports.dart';

class BuildForgetPasswordEmailFieldWidget
    extends GetView<ForgetPasswordController> {
  const BuildForgetPasswordEmailFieldWidget();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: AppTrans.emailHint,
      controller: controller.emailController,
      useNativeTextField: true,
      validator: qValidator([
        IsRequired(AppTrans.emailRequired.tr(context: context)),
        IsEmail(AppTrans.notEmailError.tr(context: context)),
      ]),
      shouldAutoValidate: true,
      onValidationChanged: (isValid) {
        controller.isEmailValid.value = isValid;
      },
      type: TextInputType.emailAddress,
      prefix: Padding(
        padding: context.paddingOnly(start: 12.0, end: 8.0),
        child: IconInfo.svg(
          Assets.icons.icEmail,
          size: 16.r,
          color: context.colors.inputHintColor,
        ).buildIconWidget(),
      ),
      autoFillHints: const [AutofillHints.email],
      onSubmitted: (_) => controller.submitForgetPassword(),
      borderRadius: 12.radius,
      fillColor: context.colors.inputBackgroundColor,
      borderColor: context.colors.inputBorderColor,
      focusedBorderColor: context.colors.inputBorderColor,
      contentPadding: context
          .paddingSymmetric(vertical: 14)
          .resolve(Directionality.of(context)),
      hintStyle: context.bodyMediumTS.copyWith(
        color: context.colors.inputHintColor,
        fontSize: 14.sp,
        height: 1.43,
        fontWeight: FontWeight.w400,
      ),
      inputTextStyle: context.bodyMediumTS.copyWith(
        color: context.colors.inputTextColor,
        fontSize: 14.sp,
        height: 1.43,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
