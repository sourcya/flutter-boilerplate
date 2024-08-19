import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_launch/auth/ui/login/imports/login_imports.dart';
import '../../app/app_launch/onboarding/ui/imports/onboarding_imports.dart';
import '../../app/app_launch/splash/ui/imports/splash_imports.dart';
import '../../app/dashboard/ui/imports/dashboard_imports.dart';
import '../../app/settings/ui/imports/settings_imports.dart';
import '../../app/wishlist/ui/imports/wishlist_imports.dart';
import '../widgets/navigation/custom_page.dart';
import 'app_routes.dart';
import 'go_router/playx_page_transition.dart';
import 'go_router/playx_route.dart';
import 'navigation_utils.dart';

/// contains all possible routes for the application.
class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final _homeNavigationRoutes = StatefulShellRoute.indexedStack(
    // builder: (context, state, navigationShell) {
    //   return CustomPageScaffold(
    //     // state: state,
    //     navigationShell: navigationShell,
    //     showBottomNav: NavigationUtils.showBottomNav,
    //     canShowDrawer: NavigationUtils.canShowDrawer,
    //     canShowNavigationRail: NavigationUtils.showNavigationRail,
    //   );
    // },
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
            builder: (ctx, state) => DashboardView(),
            transition: PlayxPageTransition.fade,
            binding: DashboardBinding(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.wishlist,
            name: Routes.wishlist,
            builder: (ctx, state) {
              return WishlistView();
            },
            binding: WishlistBinding(),
            routes: [
              PlayxRoute(
                path: Paths.wishlistDetails,
                name: Routes.wishlistDetails,
                transition: PlayxPageTransition.fade,
                builder: (ctx, state) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Wishlist Details'),
                    ),
                  );
                },
                binding: WishlistDetailsBinding(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.settings,
            name: Routes.settings,
            builder: (ctx, state) => const SettingsView(),
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
      builder: (context, state) => const SplashView(),
      binding: SplashBinding(),
    ),
    PlayxRoute(
      path: Paths.login,
      name: Routes.login,
      builder: (context, state) => const LoginView(),
      binding: LoginBinding(),
    ),
    PlayxRoute(
      path: Paths.onboarding,
      name: Routes.onboarding,
      builder: (context, state) => OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    _homeNavigationRoutes,
  ];
}
