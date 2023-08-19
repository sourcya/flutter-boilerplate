import 'package:playx/playx.dart';

import '../../app/auth/ui/login/imports/login_imports.dart';
import '../../app/auth/ui/register/imports/register_imports.dart';
import '../../app/home/ui/imports/home_imports.dart';
import '../../app/onboarding/ui/imports/onboarding_imports.dart';
import '../../app/settings/ui/imports/settings_imports.dart';
import '../../app/splash/ui/imports/splash_imports.dart';
import 'app_routes.dart';

/// contains all possible routes for the application.
class AppPages {
  AppPages._();

  static const initial = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.Settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () =>  OnBoardingView(),
      binding: OnBoardingBinding(),
    ),

  ];
}
