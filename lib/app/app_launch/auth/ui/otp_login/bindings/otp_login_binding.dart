part of '../imports/login_view_imports.dart';

class OtpLoginBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<OtpLoginController>()) {
      Get.put(OtpLoginController());
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<OtpLoginController>()) {
      Get.delete<OtpLoginController>();
    }
  }
}
