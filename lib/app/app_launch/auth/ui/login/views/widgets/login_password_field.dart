part of '../../imports/login_imports.dart';

class LoginPasswordField extends GetView<LoginController> {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomTextField(
        hint: AppTrans.passwordHint,
        obscureText: controller.hidePassword.value,
        type: TextInputType.visiblePassword,
        focus: controller.passwordFocusNode,
        onTap: controller.focusPasswordField,
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
            controller.hidePassword.value = !controller.hidePassword.value;
          },
          child: Padding(
            padding: context.paddingOnly(end: 12.0, start: 8.0),
            child: IconInfo.svg(
              controller.hidePassword.value
                  ? Assets.icons.icEyeOff
                  : Assets.icons.icEye,
              size: 16.r,
              color: context.colors.inputHintColor,
            ).buildIconWidget(),
          ),
        ),
        controller: controller.passwordController,
        validator: qValidator([
          IsRequired(AppTrans.passwordRequired.tr(context: context)),
        ]),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.isPasswordValid.value = isValid;
        },
        autoFillHints: const [AutofillHints.password],
        onSubmitted: (_) {
          controller.signIn();
        },
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
