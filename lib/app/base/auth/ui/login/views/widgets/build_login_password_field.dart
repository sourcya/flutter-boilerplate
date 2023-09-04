
part of '../../imports/login_imports.dart';

class BuildLoginPasswordFieldWidget extends GetView<LoginController> {

    const BuildLoginPasswordFieldWidget();

    @override
    Widget build(BuildContext context) {
        return Obx(() {
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                ),
                child: CustomTextField(
                    label: AppTrans.passwordLabel.tr,
                    hint: AppTrans.passwordHint.tr,
                    controller: controller.passwordController,
                    obscureText: controller.hidePassword.value,
                    type: TextInputType.visiblePassword,
                    suffix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: IconButton(
                            icon: Icon(
                                controller.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20.r,
                            ),
                            onPressed: () {
                                controller.hidePassword.value = !controller.hidePassword.value;
                            },
                            color: colorScheme.secondary,
                        ),
                    ),
                    validator: qValidator([
                        IsRequired(
                            AppTrans.passwordRequired.tr,
                        ),
                        MinLength(6, AppTrans.passwordMinLengthError.tr)
                    ]),
                    prefix: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Icon(
                            Icons.lock,
                            color: colorScheme.secondary,
                            size: 20.r,
                        ),
                    ),
                    shouldAutoValidate: true,
                    onValidationChanged: (isValid) {
                        controller.isPasswordValid.value = isValid;
                    },
                ),
            );
        });
    }
}
