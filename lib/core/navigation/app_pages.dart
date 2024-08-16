import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/core/navigation/navigation_utils.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_launch/auth/ui/otp_login/imports/login_view_imports.dart';
import '../../app/app_launch/auth/ui/verify_phone/imports/verify_phone_view_imports.dart';
import '../../app/app_launch/onboarding/ui/imports/onboarding_imports.dart';
import '../../app/app_launch/splash/ui/imports/splash_imports.dart';
import '../../app/dashboard/ui/imports/dashboard_imports.dart';
import '../../app/settings/ui/imports/settings_imports.dart';
import '../../app/wishlist/ui/imports/wishlist_imports.dart';
import '../widgets/navigation/custom_page.dart';
import 'app_routes.dart';
import 'go_router/playx_route.dart';

/// contains all possible routes for the application.
class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final _homeNavigationRoutes = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) {
      return CustomPageScaffold.buildPage(
        state: state,
        navigationShell: navigationShell,
        showBottomNav: NavigationUtils.showBottomNav,
        canShowDrawer: NavigationUtils.canShowDrawer,
        canShowNavigationRail: NavigationUtils.showNavigationRail,
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.dashboard,
            name: Routes.dashboard,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: DashboardView(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
            binding: DashboardBinding(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.wishlist,
            name: Routes.wishlist,
            pageBuilder: (context, state) => CupertinoPage(
              child: WishlistView(),
              key: state.pageKey,
            ),
            binding: WishlistBinding(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.settings,
            name: Routes.settings,
            pageBuilder: (context, state) => CupertinoPage(
              child: const SettingsView(),
              key: state.pageKey,
            ),
            binding: SettingsBinding(),
          ),
        ],
      ),
    ],
  );

  static final routes = [
    PlayxRoute(
      path: Paths.splash,
      name: Routes.splash,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SplashView(),
        key: state.pageKey,
      ),
      binding: SplashBinding(),
    ),
    PlayxRoute(
      path: Paths.login,
      name: Routes.login,
      pageBuilder: (context, state) => CupertinoPage(
        child: const OtpLoginView(),
        key: state.pageKey,
      ),
      binding: OtpLoginBinding(),
    ),
    PlayxRoute(
      path: Paths.verifyPhone,
      name: Routes.verifyPhone,
      pageBuilder: (context, state) => CupertinoPage(
        child: const VerifyPhoneView(),
        key: state.pageKey,
      ),
      binding: VerifyPhoneBinding(),
    ),
    PlayxRoute(
      path: Paths.onboarding,
      name: Routes.onboarding,
      pageBuilder: (context, state) => CupertinoPage(
        child: OnBoardingView(),
        key: state.pageKey,
      ),
      binding: OnBoardingBinding(),
    ),
    _homeNavigationRoutes,
  ];
}
