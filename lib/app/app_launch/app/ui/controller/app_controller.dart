part of '../imports/app_imports.dart';

class AppController extends GetxController {
  static AppController get instance => Get.find<AppController>();

  int currentDrawerIndex = 0;
  int currentBottomNavIndex = 0;

  final showBottomNav = true.obs;
  final isLoggingOut = false.obs;

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

  Future<void> handleLogout() async {
    updateLoginStatus(isLoggingOut: true);
    try {
      await AuthRepository().logout(logOutFromAuth0: false);
    } catch (e) {
      Alert.error(message: e.toString());
    }
    isLoggingOut.value = false;
    await Future.delayed(const Duration(milliseconds: 200));
    AppNavigation.navigateToSplash();
    showBottomNav.value = true;
  }

  void updateLoginStatus({required bool isLoggingOut}) {
    this.isLoggingOut.value = isLoggingOut;
    showBottomNav.value = !isLoggingOut;
  }
}
