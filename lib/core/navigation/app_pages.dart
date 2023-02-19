import 'package:flutter_boilerplate/app/select_language/ui/bindings/select_language_binding.dart';
import 'package:flutter_boilerplate/app/select_language/ui/views/select_language_view.dart';
import 'package:get/get.dart';

import '../../app/auth/ui/login/bindings/login_binding.dart';
import '../../app/auth/ui/login/views/login_view.dart';
import '../../app/auth/ui/register/bindings/register_binding.dart';
import '../../app/auth/ui/register/views/register_view.dart';
import '../../app/home/ui/bindings/home_binding.dart';
import '../../app/home/ui/views/home_view.dart';
import '../../app/splash/ui/bindings/splash_binding.dart';
import '../../app/splash/ui/views/splash_view.dart';
import 'app_routes.dart';

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
      name: Routes.LANGUAGE,
      page: () => const SelectLanguageView(),
      binding: SelectLanguageBinding(),
    ),
  ];
}
