import 'package:playx/playx.dart';

import '../../app/auth/ui/login/bindings/login_binding.dart';
import '../../app/auth/ui/login/views/login_view.dart';
import '../../app/auth/ui/register/bindings/register_binding.dart';
import '../../app/auth/ui/register/views/register_view.dart';
import '../../app/home/ui/bindings/home_binding.dart';
import '../../app/home/ui/views/home_view.dart';
import '../../app/onboarding/ui/binding/onboarding_binding.dart';
import '../../app/onboarding/ui/view/onboarding_view.dart';
import '../../app/settings/ui/binding/settings_binding.dart';
import '../../app/settings/ui/view/settings_view.dart';
import '../../app/splash/ui/bindings/splash_binding.dart';
import '../../app/splash/ui/views/splash_view.dart';
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
