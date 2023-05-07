import 'package:get/get.dart';

import 'app_routes.dart';

/// This class is responsible for handling the app navigation.
/// for each navigation from screen to another add it here.
class AppNavigation {
  static AppNavigation get instance => Get.find<AppNavigation>();

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
}
