part of '../imports/custom_navigation_drawer_imports.dart';

class CustomNavigationDrawerController extends GetxController {
  int currentIndex = 0;
  final isLoggingOut = false.obs;
  CustomBottomNavigationController get bottomNavController =>
      Get.find<CustomBottomNavigationController>();

  void updateIndex(int index) {
    if (index < 3) {
      currentIndex = index;
    } else if (index < 0) {
      currentIndex = 0;
    }
  }

  void handleItemChanged(
      {required int index, required StatefulNavigationShell navigationShell}) {
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
    bottomNavController.showBottomNav.value = true;
  }

  void updateLoginStatus({required bool isLoggingOut}) {
    this.isLoggingOut.value = isLoggingOut;
    bottomNavController.showBottomNav.value = !isLoggingOut;
  }
}
