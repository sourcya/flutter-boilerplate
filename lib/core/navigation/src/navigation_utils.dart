part of '../navigation.dart';

class NavigationUtils {
  NavigationUtils._();

  static List<String> get mainRoutes => [
        Routes.dashboard,
        Routes.settings,
      ];

  static List<String> get routesBottomNav => [
        Routes.dashboard,
        Routes.settings,
        Routes.wishlist,
      ];

  static bool get showBottomNav =>
      routesBottomNav.contains(PlayxNavigation.currentRouteName);

  static bool get canShowDrawer => AppUtils.isMobile();

  static bool get showNavigationRail => !AppUtils.isMobile();

  static GlobalKey<NavigatorState> get navigatorKey =>
      AppPages.router.routerDelegate.navigatorKey;

  static BuildContext? get navigationContext => navigatorKey.currentContext;
}
