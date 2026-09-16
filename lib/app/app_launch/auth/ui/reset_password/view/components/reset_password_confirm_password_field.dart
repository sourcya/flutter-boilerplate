part of '../../imports/reset_password_imports.dart';

class ResetPasswordConfirmPasswordField
    extends GetView<ResetPasswordController> {
  const ResetPasswordConfirmPasswordField();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomTextField(
        formKey: controller.confirmPasswordFormKey,
        hint: AppTrans.confirmPasswordHint,
        obscureText: controller.hideConfirmPassword.value,
        type: TextInputType.visiblePassword,
        useNativeTextField: true,
        prefix: Padding(
          padding: context.paddingOnly(start: 12.0, end: 8.0),
          child: IconInfo.svg(
            Assets.icons.icLock,
            size: 16.r,
            color: context.colors.inputHintColor,
          ).buildIconWidget(),
        ),
        suffix: InkWell(
          onTap: () {
            controller.hideConfirmPassword.value =
                !controller.hideConfirmPassword.value;
          },
          child: Padding(
            padding: context.paddingOnly(end: 12.0, start: 8.0),
            child: IconInfo.svg(
              controller.hideConfirmPassword.value
                  ? Assets.icons.icEyeOff
                  : Assets.icons.icEye,
              size: 16.r,
              color: context.colors.inputHintColor,
            ).buildIconWidget(),
          ),
        ),
        controller: controller.confirmPasswordController,
        validator: qValidator([
          IsRequired(
            AppTrans.confirmPasswordRequiredError.tr(context: context),
          ),
          AreEqual(
            other: () => controller.passwordController.text,
            errorMsg: AppTrans.confirmPasswordMatchError.tr(context: context),
          ),
        ]),
        shouldAutoValidate: true,
        onChanged: (_) {
          if (controller.passwordController.text.isNotEmpty) {
            AppUtils.validate(
              controller.newPasswordFormKey,
              controller.isPasswordValid,
            );
          }
        },
        onValidationChanged: (bool isValid) {
          controller.isConfirmPasswordValid.value = isValid;
        },
        autoFillHints: const [AutofillHints.newPassword],
        onSubmitted: (_) => controller.resetPassword(),
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
    });
  }
}
