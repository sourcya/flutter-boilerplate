part of '../../../imports/change_password_imports.dart';

class ChangePasswordContentWidget extends StatelessWidget {
  final ChangePasswordController controller;
  final EdgeInsetsGeometry padding;
  final bool isWideLayout;

  const ChangePasswordContentWidget({
    super.key,
    required this.controller,
    required this.padding,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangePasswordFieldWidget(
            isWideLayout: isWideLayout,
            label: isWideLayout ? AppTrans.changePasswordCurrentPasswordText : null,
            hint: AppTrans.changePasswordOldPasswordHint,
            controller: controller.oldPasswordController,
            hidePassword: controller.hideOldPassword,
            onValidationChanged: (isValid) {
              controller.isOldPasswordValid.value = isValid;
            },
            validator: qValidator([
              IsRequired(
                AppTrans.changeOldPasswordRequired.tr(context: context),
              ),
            ]),
            autofillHints: const [AutofillHints.password],
          ),
          16.hBox,
          ChangePasswordFieldWidget(
            isWideLayout: isWideLayout,
            label: isWideLayout ? AppTrans.changePasswordNewPasswordText : null,
            formKey: controller.newPasswordFormKey,
            hint: AppTrans.changePasswordNewPasswordHint,
            controller: controller.passwordController,
            hidePassword: controller.hidePassword,
            onValidationChanged: (isValid) {
              controller.isPasswordValid.value = isValid;
            },
            onChanged: (text) {
              if (controller.confirmPasswordController.text.isNotEmpty) {
                AppUtils.validate(
                  controller.confirmPasswordFormKey,
                  controller.isConfirmPasswordValid,
                );
              }
            },
            validator: qValidator([
              IsRequired(AppTrans.passwordRequired.tr(context: context)),
              MinLength(
                8,
                AppTrans.passwordMinLengthError.tr(context: context),
              ),
              AreNotEqual(
                other: () => controller.oldPasswordController.text,
                errorMsg: AppTrans.oldPasswordAndNewMatchError.tr(
                  context: context,
                ),
              ),
            ]),
            autofillHints: const [AutofillHints.newPassword],
          ),
          16.hBox,
          ChangePasswordFieldWidget(
            isWideLayout: isWideLayout,
            label: isWideLayout ? AppTrans.confirmPasswordTitle : null,
            formKey: controller.confirmPasswordFormKey,
            hint: AppTrans.changePasswordConfirmPasswordHint,
            controller: controller.confirmPasswordController,
            hidePassword: controller.hideConfirmPassword,
            onValidationChanged: (isValid) {
              controller.isConfirmPasswordValid.value = isValid;
            },
            onChanged: (value) {
              if (controller.confirmPasswordController.text.isNotEmpty) {
                AppUtils.validate(
                  controller.newPasswordFormKey,
                  controller.isPasswordValid,
                );
              }
            },
            validator: qValidator([
              IsRequired(
                AppTrans.confirmPasswordRequiredError.tr(context: context),
              ),
              AreEqual(
                other: () => controller.passwordController.text,
                errorMsg: AppTrans.confirmPasswordNotMatchError.tr(
                  context: context,
                ),
              ),
            ]),
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
          ),
        ],
      ),
    );
  }
}
