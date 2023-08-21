import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/app/auth/ui/otp_login/imports/login_view_imports.dart';
import 'package:flutter_boilerplate/app/auth/ui/verify_phone/imports/verify_phone_view_imports.dart';
import 'package:flutter_boilerplate/app/wishlist/ui/imports/wishlist_imports.dart';
import 'package:playx/playx.dart';

import '../../app/dashboard/ui/imports/dashboard_imports.dart';
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
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const OtpLoginView(),
      binding: OtpLoginBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.VERIFY_PHONE,
      page: () => const VerifyPhoneView(),
      binding: VerifyPhoneBinding(),
      transition: Transition.cupertino,
    ),

    // GetPage(
    //   name: Routes.REGISTER,
    //   page: () => const RegisterView(),
    //   binding: RegisterBinding(),
    // ),

    GetPage(
      name: Routes.ONBOARDING,
      page: () =>  OnBoardingView(),
      binding: OnBoardingBinding(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.cupertino,
    ),
  ];

  static Route? onGenerateFirstRoute(RouteSettings settings) {
    final name = settings.name;
    switch (name) {
      case Routes.DASHBOARD:
        return GetPageRoute(
          settings: settings,
          page: () =>  DashboardView(),
          binding: DashboardBinding(),
          transition: Transition.cupertino,
        );
    }
    return null;
  }


  static Route? onGenerateSecondRoute(RouteSettings settings) {
    final name = settings.name;
    switch (name) {
      case Routes.WISHLIST:
        return GetPageRoute(
          settings: settings,
          page: () =>  WishlistView(),
          binding: WishlistBinding(),
          transition: Transition.cupertino,
        );
    }
    return null;
  }
  static Route? onGenerateThirdRoute(RouteSettings settings) {
    final name = settings.name;
    switch (name) {
      case Routes.SETTINGS:
        return GetPageRoute(
          settings: settings,
          page: () =>  const SettingsView(),
          binding: SettingsBinding(),
          transition: Transition.cupertino,
        );
    }
    return null;
  }


}
