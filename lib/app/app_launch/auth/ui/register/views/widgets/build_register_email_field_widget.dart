part of '../../imports/register_imports.dart';

class BuildRegisterEmailFieldWidget extends GetView<RegisterController> {
  const BuildRegisterEmailFieldWidget();

  @override
  Widget build(BuildContext context) {
    return BuildRegisterFieldWidget(
      label: AppTrans.emailOrUsernameLabel,
      textField: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.r),
        child: CustomTextField(
          hint: AppTrans.emailHint,
          controller: controller.emailController,
          type: TextInputType.emailAddress,
          validator: qValidator([
            IsRequired(AppTrans.emailRequired.tr(context: context)),
            IsEmail(AppTrans.notEmailError.tr(context: context)),
          ]),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.r,
            vertical: 10.r,
          ),
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
