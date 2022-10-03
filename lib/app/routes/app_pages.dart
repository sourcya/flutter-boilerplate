import 'package:flutter_boilerplate/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_boilerplate/app/modules/home/views/home_view.dart';
import 'package:flutter_boilerplate/app/modules/select_language/bindings/select_language_binding.dart';
import 'package:flutter_boilerplate/app/modules/select_language/views/select_language_view.dart';
import 'package:flutter_boilerplate/app/modules/sign_in/bindings/sign_in_binding.dart';
import 'package:flutter_boilerplate/app/modules/sign_in/views/sign_in_view.dart';
import 'package:flutter_boilerplate/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_boilerplate/app/modules/splash/views/splash_view.dart';
import 'package:get/get.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_LANGUAGE,
      page: () => const SelectLanguageView(),
      binding: SelectLanguageBinding(),
    ),
  ];
}
