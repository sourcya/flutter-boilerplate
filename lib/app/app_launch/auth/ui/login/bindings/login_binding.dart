part of '../imports/login_imports.dart';

///Getx binding to initialize login controller.
class LoginBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController());
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (Get.isRegistered<LoginController>()) {
      Get.delete<LoginController>();
    }
  }
}
