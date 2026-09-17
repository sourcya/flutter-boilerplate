part of '../imports/login_imports.dart';

class LoginBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (Get.isRegistered<LoginController>()) {
      Get.delete<LoginController>();
    }
    Get.put(
      LoginController(
        repo: AuthRepository.instance,
      ),
    );
    if (Get.isRegistered<OnboardingSlidesCarouselController>()) {
      Get.delete<OnboardingSlidesCarouselController>();
    }
    Get.put(OnboardingSlidesCarouselController());
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<LoginController>()) {
      Get.delete<LoginController>();
    }
    if (Get.isRegistered<OnboardingSlidesCarouselController>()) {
      Get.delete<OnboardingSlidesCarouselController>();
    }
  }
}
