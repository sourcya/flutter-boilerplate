part of '../imports/onboarding_imports.dart';

class OnBoardingBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<OnBoardingController>()) {
      Get.put(OnBoardingController());
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<OnBoardingController>()) {
      Get.delete<OnBoardingController>();
    }
  }
}
