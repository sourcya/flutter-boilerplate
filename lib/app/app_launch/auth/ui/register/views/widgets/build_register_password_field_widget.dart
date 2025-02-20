part of '../../imports/register_imports.dart';

class BuildRegisterPasswordFieldWidget extends GetView<RegisterController> {
  const BuildRegisterPasswordFieldWidget();

  @override
  Widget build(BuildContext context) {
    return BuildRegisterFieldWidget(
      label: AppTrans.passwordLabel,
      textField: Obx(() {
        return CustomTextField(
          hint: AppTrans.passwordHint,
          controller: controller.passwordController,
          obscureText: controller.hidePassword.value,
          type: TextInputType.visiblePassword,
          suffix: IconButton(
            icon: Icon(
              controller.hidePassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: controller.changeHidePasswordState,
            // color: context.colors.secondary,
          ),
          validator: qValidator([
            IsRequired(
              AppTrans.passwordRequired.tr(context: context),
            ),
            MinLength(
              6,
              AppTrans.passwordMinLengthError.tr(context: context),
            ),
          ]),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.r,
            vertical: 10.r,
          ),
          prefix: Icon(
            Icons.lock,
            color: context.colors.onSurface,
            size: 18.r,
          ),
          onChanged: (text) {
            if (controller.confirmPasswordController.value.text.isNotEmpty) {
              AppUtils.validate(
                controller.confirmPasswordFormKey,
                controller.isConfirmPasswordValid,
              );
            }
          },
          shouldAutoValidate: true,
          onValidationChanged: (isValid) {
            controller.isPasswordValid.value = isValid;
          },
          textInputAction: TextInputAction.next,
          focus: controller.passwordFocus,
          nextFocus: controller.confirmPasswordFocus,
        );
      }),
    );
  }
}
