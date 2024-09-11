part of '../imports/bottom_navigation_imports.dart';

PlatformNavBar buildCustomNavigationBar({
  required BuildContext context,
  required StatefulNavigationShell navigationShell,
}) {
  final controller = Get.find<CustomBottomNavigationController>();
  controller.updateIndex(navigationShell.currentIndex);

  return PlatformNavBar(
    currentIndex: controller.currentIndex,
    itemChanged: (index) {
      controller.handleItemChanged(
        index: index,
        navigationShell: navigationShell,
      );
    },
    material3: (context, platform) {
      return MaterialNavigationBarData(
          indicatorColor: context.colors.primary,
          // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          // backgroundColor: context.colors.surface,
          items: [
            NavigationDestination(
              icon: Icon(
                Icons.dashboard,
                color: controller.currentIndex == 0
                    ? context.colors.onPrimary
                    : context.colors.onSurface,
              ),
              label: AppTrans.dashboard.tr(context: context),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_border,
                color: controller.currentIndex == 1
                    ? context.colors.onPrimary
                    : context.colors.onSurface,
              ),
              label: AppTrans.wishlist.tr(context: context),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings,
                color: controller.currentIndex == 2
                    ? context.colors.onPrimary
                    : context.colors.onSurface,
              ),
              label: AppTrans.settings.tr(context: context),
            ),
          ]);
    },
    cupertino: (context, _) {
      return CupertinoTabBarData(
        activeColor: context.colors.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: controller.currentIndex == 0
                  ? context.colors.primary
                  : context.colors.onSurface,
            ),
            label: AppTrans.dashboard.tr(context: context),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: controller.currentIndex == 1
                  ? context.colors.onPrimary
                  : context.colors.onSurface,
            ),
            label: AppTrans.wishlist.tr(context: context),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: controller.currentIndex == 2
                  ? context.colors.primary
                  : context.colors.onSurface,
            ),
            label: AppTrans.settings.tr(context: context),
          ),
        ],
      );
    },
  );
}
