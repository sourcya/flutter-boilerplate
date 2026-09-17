part of '../../imports/register_imports.dart';

class BuildRegisterEmailFieldWidget extends GetView<RegisterController> {
  const BuildRegisterEmailFieldWidget();

  @override
  Widget build(BuildContext context) {
    return BuildRegisterFieldWidget(
      label: AppTrans.emailOrUsernameLabel,
      textField: Padding(
        padding: context.paddingSymmetric(horizontal: 4.0),
        child: CustomTextField(
          hint: AppTrans.emailHint,
          controller: controller.emailController,
          type: TextInputType.emailAddress,
          validator: qValidator([
            IsRequired(AppTrans.emailRequired.tr(context: context)),
            IsEmail(AppTrans.notEmailError.tr(context: context)),
          ]),
          contentPadding: context.paddingSymmetric(horizontal: 14, vertical: 10),
          prefix: Icon(
            Icons.email,
            color: context.colors.onSurface,
            size: 18.r,
          ),
          shouldAutoValidate: true,
          onValidationChanged: (isValid) {
            controller.isEmailValid.value = isValid;
          },
          textInputAction: TextInputAction.next,
          focus: controller.emailFocus,
          nextFocus: controller.passwordFocus,
        ),
      ),
    );
  }
}
