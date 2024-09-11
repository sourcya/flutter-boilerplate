part of '../../imports/login_imports.dart';

class BuildLoginButtonWidget extends GetView<LoginController> {
  const BuildLoginButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomElevatedButton(
        onPressed: controller.isFormValid.value ? controller.login : null,
        label: AppTrans.loginText,
      );
    });
  }
}
