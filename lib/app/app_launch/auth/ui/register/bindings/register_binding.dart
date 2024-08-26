part of '../imports/register_imports.dart';

class RegisterBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<RegisterController>()) {
      Get.put(RegisterController());
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (Get.isRegistered<RegisterController>()) {
      Get.delete<RegisterController>();
    }
  }
}
