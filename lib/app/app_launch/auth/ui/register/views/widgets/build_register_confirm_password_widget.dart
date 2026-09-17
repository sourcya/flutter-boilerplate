part of '../../imports/register_imports.dart';

class BuildRegisterConfirmPasswordWidget extends GetView<RegisterController> {
  const BuildRegisterConfirmPasswordWidget();

  @override
  Widget build(BuildContext context) {
    return BuildRegisterFieldWidget(
      label: AppTrans.confirmPasswordLabel,
      textField: Obx(() {
        return CustomTextField(
          hint: AppTrans.confirmPasswordHint,
          controller: controller.confirmPasswordController,
          obscureText: controller.hideConfirmPassword.value,
          type: TextInputType.visiblePassword,
          suffix: IconButton(
            icon: Icon(
              controller.hideConfirmPassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: controller.changeHideConfirmPasswordState,
            // color: context.colors.secondary,
          ),
          contentPadding: context.paddingSymmetric(horizontal: 14, vertical: 10),
          validator: qValidator([
            IsRequired(
              AppTrans.passwordRequired.tr(context: context),
            ),
            AreEqual(
              other: () => controller.passwordController.value.text,
              errorMsg: AppTrans.confirmPasswordMatchError.tr(context: context),
            ),
          ]),
          prefix: Icon(
            Icons.lock,
            color: context.colors.onSurface,
            size: 18.r,
          ),
          shouldAutoValidate: true,
          onValidationChanged: (isValid) {
            controller.isConfirmPasswordValid.value = isValid;
          },
          focus: controller.confirmPasswordFocus,
        );
      }),
    );
  }
}
