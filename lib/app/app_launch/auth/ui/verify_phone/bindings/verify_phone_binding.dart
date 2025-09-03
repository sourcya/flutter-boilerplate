part of '../imports/verify_phone_view_imports.dart';

class VerifyPhoneBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<VerifyPhoneController>()) {
      Get.put(VerifyPhoneController(authRepository: AuthRepository.instance));
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<VerifyPhoneController>()) {
      Get.delete<VerifyPhoneController>();
    }
  }
}
