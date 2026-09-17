part of '../navigation.dart';

abstract class AppNavigation {
  AppNavigation._();

  static void navigateFormSplashToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  static void navigateFormSplashToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromLoginToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  static void navigateFromLoginToForgetPassword() {
    PlayxNavigation.toNamed(Routes.forgetPassword);
  }

  static void navigateFromForgetPasswordToPasswordOtp({
    required String email,
    DateTime? createOtpTime,
  }) {
    final sentAt = (createOtpTime ?? DateTime.now()).millisecondsSinceEpoch;
    PlayxNavigation.toNamed(
      Routes.passwordOtp,
      queryParameters: {
        'email': email,
        'otpSentAt': '$sentAt',
      },
    );
  }

  static void navigateFromPasswordOtpToResetPassword({
    required String token,
    required String email,
  }) {
    PlayxNavigation.pop();
    PlayxNavigation.toNamed(
      Routes.resetPassword,
      queryParameters: {'email': email},
      extra: token,
    );
  }

  static void navigateFromResetPasswordToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
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

  static void navigateFromRegisterToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateFromRegisterToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  static void navigateFromSettingsToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateToLogin() {
    PlayxNavigation.offAllNamed(Routes.login);
  }

  static void navigateToSettings({SettingsTabs? tab}) {
    PlayxNavigation.offAllNamed(
      Routes.settings,
      queryParameters: tab == null ? const {} : {'tab': tab.name},
    );
  }

  static void navigateToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  /// Extension point: register is not part of the boilerplate shell.
  static void navigateFromLoginToRegister() {}

  /// Extension point: OTP is not part of the boilerplate shell.
  static void navigateFromLoginToVerifyPhone() {}

  static void navigateFromVerifyOtpToHome() {
    PlayxNavigation.offAllNamed(AppPages.homeRoute);
  }

  static void goToBranch({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    PlayxNavigation.goToBranch(
      index: index,
      navigationShell: navigationShell,
    );
  }

  static void pop() {
    PlayxNavigation.pop();
  }

  static void navigateOffAll({required String routeName}) {
    PlayxNavigation.offAllNamed(routeName);
  }
}
