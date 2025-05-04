part of '../imports/app_imports.dart';

class AppController extends GetxController {
  static AppController get instance => Get.find<AppController>();

  int currentDrawerIndex = 0;
  int currentBottomNavIndex = 0;

  final showBottomNav = true.obs;
  final loadingStatus = LoadingStatus.none.obs;

  late final List<CustomNavigationDestinationItem> bottomNavItems = [
    CustomNavigationDestinationItem(
      icon: IconInfo(
        icon: Icons.home_outlined,
      ),
      label: AppTrans.home,
      navigationIndex: 0,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(
        icon: Icons.favorite_border,
      ),
      label: AppTrans.wishlist,
      navigationIndex: 1,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(
        icon: Icons.settings,
      ),
      label: AppTrans.settings,
      navigationIndex: 2,
    ),
  ];

  void updateBottomNavIndex(int index) {
    if (index < 3) {
      currentBottomNavIndex = index;
    } else if (index < 0) {
      currentBottomNavIndex = 0;
    }
  }

  void handleBottomNavItemChanged({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    PlayxNavigation.goToBranch(index: index, navigationShell: navigationShell);
  }

  void updateDrawerIndex(int index) {
    if (index < 3) {
      currentDrawerIndex = index;
    } else if (index < 0) {
      currentDrawerIndex = 0;
    }
  }

  void handleDrawerItemChanged({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    if (index == 3) {
      handleLogout();
      return;
    }
    PlayxNavigation.goToBranch(index: index, navigationShell: navigationShell);
  }

  Future<void> handleLogout(
      {bool showLoadingOverlay = true, bool navigateToLogin = true}) async {
    if (showLoadingOverlay) {
      _updateLoginStatus(isLoggingOut: true);
    }
    await ApiHelper.instance.logout();
    await Future.delayed(const Duration(milliseconds: 200));
    if (showLoadingOverlay) {
      _updateLoginStatus(isLoggingOut: false);
    }
    if (navigateToLogin) {
      AppNavigation.navigateToLogin();
    }
  }

  void _updateLoginStatus({required bool isLoggingOut}) {
    loadingStatus.value =
        isLoggingOut ? LoadingStatus.logout : LoadingStatus.none;
    showBottomNav.value = !isLoggingOut;
  }
}
