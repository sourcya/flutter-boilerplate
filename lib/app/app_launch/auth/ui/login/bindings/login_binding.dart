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
  Future<void> onExit(BuildContext context, GoRouterState state) async {
    await Future.delayed(500.milliseconds);
    if (Get.isRegistered<LoginController>()) {
      Get.delete<LoginController>();
    }
  }
}
