import 'package:get/get.dart';

import 'app_routes.dart';

/// This class is responsible for handling the app navigation.
/// for each navigation from screen to another add it here.
class AppNavigation {
  static AppNavigation get instance => Get.find<AppNavigation>();

  final firstTabNavigatorKey = Get.nestedKey(1);
  final secondTabNavigatorKey = Get.nestedKey(2);
  final thirdTabNavigatorKey = Get.nestedKey(3);

  Future<bool> popFirstTab() async {
    return await firstTabNavigatorKey?.currentState?.maybePop() ?? false;
  }

  Future<bool> popSecondTab() async {
    return await secondTabNavigatorKey?.currentState?.maybePop() ?? false;
  }

  Future<bool> popThirdTab() async {
    return await thirdTabNavigatorKey?.currentState?.maybePop() ?? false;
  }




  void navigateFormSplashToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void navigateFormSplashToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateFromLoginToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  void navigateFromLoginToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void navigateFromRegisterToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateFromRegisterToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void navigateToSplash() {
    Get.offAllNamed(Routes.SPLASH);
  }

  void navigateFromSplashToOnBoarding() {
    Get.offAllNamed(Routes.ONBOARDING);
  }

  void navigateFromOnBoardingToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateFromVerifyOtpToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void navigateFromLoginToVerifyPhone() {
    Get.toNamed(Routes.VERIFY_PHONE);
  }

  void navigateFromSettingsToLogin () {
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateToLogin  () {
    Get.offAllNamed(Routes.LOGIN);
  }

}
