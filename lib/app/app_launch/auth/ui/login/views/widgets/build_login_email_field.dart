part of '../../imports/login_imports.dart';

class BuildLoginEmailFieldWidget extends GetView<LoginController> {
  const BuildLoginEmailFieldWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: CustomTextField(
        label: AppTrans.emailOrUsernameLabel.tr(context: context),
        hint: AppTrans.emailHint.tr(context: context),
        controller: controller.emailController,
        type: TextInputType.emailAddress,
        validator: qValidator([
          IsRequired(AppTrans.emailRequired.tr(context: context)),
        ]),
        prefix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Icon(
            Icons.email,
            color: context.colors.primary,
            size: 20.r,
          ),
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.isEmailValid.value = isValid;
        },
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
