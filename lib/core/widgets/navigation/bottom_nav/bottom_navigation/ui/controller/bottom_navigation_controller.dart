part of '../imports/bottom_navigation_imports.dart';

class CustomBottomNavigationController extends GetxController {
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  void updateIndex(int index) {
    if (index < 3) {
      currentIndex = index;
    } else if (index < 0) {
      currentIndex = 0;
    }
  }

  void handleItemChanged(
      {required int index, required StatefulNavigationShell navigationShell}) {
    AppRouter.goToBranch(index: index, navigationShell: navigationShell);
  }
}