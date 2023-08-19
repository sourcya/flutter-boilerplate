
part of '../../imports/login_imports.dart';

class BuildLoginEmailFieldWidget extends GetView<LoginController> {

    const BuildLoginEmailFieldWidget();

    @override
    Widget build(BuildContext context) {
        return  Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
            ),
            child: CustomTextField(
                label: AppTrans.emailOrUsernameLabel.tr,
                hint: AppTrans.emailHint.tr,
                controller: controller.emailController,
                type: TextInputType.emailAddress,
                validator: qValidator([
                    IsRequired(AppTrans.emailRequired.tr),
                ]),
                prefix: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Icon(
                        Icons.email,
                        color: colorScheme.secondary,
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
