import 'app_routes.dart';
import 'go_router/app_router.dart';

/// This class is responsible for handling the app navigation.
/// for each navigation from screen to another add it here.
abstract class AppNavigation {
  AppNavigation._();

  static void navigateFormSplashToDashboard() {
    AppRouter.offAllNamed(Routes.dashboard);
  }

  static void navigateFormSplashToLogin() {
    AppRouter.offAllNamed(Routes.login);
  }

  static void navigateFromLoginToRegister() {
    AppRouter.toNamed(Routes.register);
  }

  static void navigateFromLoginToDashboard() {
    AppRouter.offAllNamed(Routes.dashboard);
  }

  static void navigateFromRegisterToLogin() {
    AppRouter.offAllNamed(Routes.login);
  }

  static void navigateFromRegisterToDashboard() {
    AppRouter.offAllNamed(Routes.dashboard);
  }

  static void navigateToSplash() {
    AppRouter.offAllNamed(Routes.splash);
  }

  static void navigateFromSplashToOnBoarding() {
    AppRouter.offAllNamed(Routes.onboarding);
  }

  static void navigateFromOnBoardingToLogin() {
    AppRouter.offAllNamed(Routes.login);
  }

  static void navigateFromVerifyOtpToDashboard() {
    AppRouter.offAllNamed(Routes.dashboard);
  }

  static void navigateFromLoginToVerifyPhone() {
    AppRouter.toNamed(Routes.verifyPhone);
  }

  static void navigateFromSettingsToLogin() {
    AppRouter.offAllNamed(Routes.login);
  }

  static void navigateToLogin() {
    AppRouter.offAllNamed(Routes.login);
  }
}
