import '../utils/app_utils.dart';
import 'app_routes.dart';
import 'go_router/app_router.dart';

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
      routesBottomNav.contains(AppRouter.currentRouteName);

  static bool get canShowDrawer => AppUtils.isMobile();

  static bool get showNavigationRail => !AppUtils.isMobile();
}
