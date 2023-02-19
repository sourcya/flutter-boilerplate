import 'package:get/get.dart';

import 'app_routes.dart';

class AppNavigation {
  static AppNavigation get instance => Get.find<AppNavigation>();

  void navigateFormSplashToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void navigateFromSplashToHome() {
    Get.offAllNamed(Routes.HOME);
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
}
