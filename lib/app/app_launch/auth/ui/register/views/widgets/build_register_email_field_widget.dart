part of '../../imports/register_imports.dart';

class BuildRegisterEmailFieldWidget extends GetView<RegisterController> {
  const BuildRegisterEmailFieldWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: CustomTextField(
        label: AppTrans.emailLabel.tr(context: context),
        hint: AppTrans.emailHint.tr(context: context),
        controller: controller.emailController,
        type: TextInputType.emailAddress,
        validator: qValidator([
          IsRequired(AppTrans.emailRequired.tr(context: context)),
          IsEmail(AppTrans.notEmailError.tr(context: context)),
        ]),
        prefix: const Icon(
          Icons.email,
          // color: context.colors.secondary,
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.isEmailValid.value = isValid;
        },
        textInputAction: TextInputAction.next,
        focus: controller.emailFocus,
        nextFocus: controller.passwordFocus,
      ),
    );
  }
}
