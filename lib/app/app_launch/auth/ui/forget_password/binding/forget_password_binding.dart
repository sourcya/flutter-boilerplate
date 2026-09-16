part of '../imports/forget_password_imports.dart';

class ForgetPasswordBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<ForgetPasswordController>()) {
      Get.put<ForgetPasswordController>(
        ForgetPasswordController(authRepository: AuthRepository.instance),
      );
    }
  }

  @override
  Future<void> onExit(BuildContext context) async {
    if (Get.isRegistered<ForgetPasswordController>()) {
      Get.delete<ForgetPasswordController>();
    }
  }
}
