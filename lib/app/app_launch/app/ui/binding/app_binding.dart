part of '../imports/app_imports.dart';

class AppBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<AppController>()) {
      Get.put(AppController());
    }
  }

  @override
  Future<void> onExit(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (Get.isRegistered<AppController>()) {
      Get.delete<AppController>();
    }
  }
}
