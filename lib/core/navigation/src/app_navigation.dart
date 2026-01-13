part of '../navigation.dart';

/// This class is responsible for handling the app navigation.
/// for each navigation from screen to another add it here.
abstract class AppNavigation {
  AppNavigation._();

  static void navigateFormSplashToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  static void navigateToHome  () {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }


  static void navigateFormSplashToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromLoginToRegister() {
    PlayxNavigation.toNamed(Routes.register);
  }

  static void navigateFromLoginToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  static void navigateFromRegisterToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromRegisterToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
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

  static void navigateFromVerifyOtpToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
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
