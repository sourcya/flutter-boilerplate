
part of '../../imports/register_imports.dart';

class BuildRegisterEmailFieldWidget extends GetView<RegisterController> {

    const BuildRegisterEmailFieldWidget();

    @override
    Widget build(BuildContext context) {
        return      Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
            ),
            child: CustomTextField(
                label: AppTrans.emailLabel.tr,
                hint: AppTrans.emailHint.tr,
                controller: controller.emailController,
                type: TextInputType.emailAddress,
                validator: qValidator([
                    IsRequired(AppTrans.emailRequired.tr),
                    IsEmail(AppTrans.notEmailError.tr),
                ]),
                prefix: Icon(
                    Icons.email,
                    // color: colorScheme.secondary,
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
