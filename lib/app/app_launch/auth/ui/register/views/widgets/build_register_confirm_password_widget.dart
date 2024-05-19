part of '../../imports/register_imports.dart';

class BuildRegisterConfirmPasswordWidget extends GetView<RegisterController> {
  const BuildRegisterConfirmPasswordWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: CustomTextField(
          label: AppTrans.confirmPasswordLabel.tr(context: context),
          hint: AppTrans.confirmPasswordHint.tr(context: context),
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
          validator: qValidator([
            IsRequired(
              AppTrans.passwordRequired.tr(context: context),
            ),
            AreEqual(
              other: () => controller.passwordController.value.text,
              errorMsg: AppTrans.confirmPasswordMatchError.tr(context: context),
            ),
          ]),
          prefix: const Icon(
            Icons.lock,
            // color: context.colors.secondary,
          ),
          shouldAutoValidate: true,
          onValidationChanged: (isValid) {
            controller.isConfirmPasswordValid.value = isValid;
          },
          focus: controller.confirmPasswordFocus,
        ),
      );
    });
  }
}
