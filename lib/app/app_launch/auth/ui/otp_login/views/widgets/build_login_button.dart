part of '../../imports/login_view_imports.dart';

class BuildLoginButton extends GetView<OtpLoginController> {
  const BuildLoginButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: context.paddingSymmetric(vertical: 8),
      child: Obx(() {
        return CustomElevatedButton(
          label: AppTrans.loginText.tr(context: context),
          onPressed:
              controller.isPhoneNumberValid.value ? controller.login : null,
          isLoading: controller.isLoading.value,
        );
      }),
    );
  }
}
