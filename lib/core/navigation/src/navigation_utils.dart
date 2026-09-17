part of '../navigation.dart';

class NavigationUtils {
  NavigationUtils._();

  static List<String> get mainRoutes => [
        Routes.dashboard,
        Routes.settings,
        Routes.reports,
        Routes.analytics,
      ];

  static List<String> get routesBottomNav => [
        Routes.dashboard,
        Routes.settings,
      ];

  static bool get showBottomNav =>
      routesBottomNav.contains(PlayxNavigation.currentRouteName);

  static GlobalKey<NavigatorState> get navigatorKey =>
      AppPages.router.routerDelegate.navigatorKey;

  static BuildContext? get navigationContext => navigatorKey.currentContext;
}
