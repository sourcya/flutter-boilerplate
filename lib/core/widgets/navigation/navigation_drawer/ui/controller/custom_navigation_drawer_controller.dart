part of '../imports/custom_navigation_drawer_imports.dart';

class CustomNavigationDrawerController extends GetxController {
  int currentIndex = 0;

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
