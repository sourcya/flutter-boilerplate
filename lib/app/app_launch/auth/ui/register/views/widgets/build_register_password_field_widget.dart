part of '../../imports/register_imports.dart';

class BuildRegisterPasswordFieldWidget extends GetView<RegisterController> {
  const BuildRegisterPasswordFieldWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: CustomTextField(
          label: AppTrans.passwordLabel.tr(context: context),
          hint: AppTrans.passwordHint.tr(context: context),
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
          prefix: Icon(
            Icons.lock,
            color: context.colors.primary,
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
        ),
      );
    });
  }
}
