import 'package:playx_navigation/playx_navigation.dart';

import 'app_routes.dart';

/// This class is responsible for handling the app navigation.
/// for each navigation from screen to another add it here.
abstract class AppNavigation {
  AppNavigation._();

  static void navigateFormSplashToDashboard() {
    PlayxNavigation.offAllNamed(Routes.dashboard);
  }

  static void navigateFormSplashToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromLoginToRegister() {
    PlayxNavigation.toNamed(Routes.register);
  }

  static void navigateFromLoginToDashboard() {
    PlayxNavigation.offAllNamed(Routes.dashboard);
  }

  static void navigateFromRegisterToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromRegisterToDashboard() {
    PlayxNavigation.offAllNamed(Routes.dashboard);
  }

  static void navigateToSplash() {
    PlayxNavigation.offAllNamed(Routes.splash);
  }

  static void navigateFromSplashToOnBoarding() {
    PlayxNavigation.offAllNamed(Routes.onboarding);
  }

  static void navigateFromOnBoardingToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromVerifyOtpToDashboard() {
    PlayxNavigation.offAllNamed(Routes.dashboard);
  }

  static void navigateFromLoginToVerifyPhone() {
    PlayxNavigation.toNamed(Routes.verifyPhone);
  }

  static void navigateFromSettingsToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }
}
