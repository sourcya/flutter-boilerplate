part of '../../imports/app_imports.dart';

PlatformNavBar buildCustomNavigationBar({
  required BuildContext context,
  required StatefulNavigationShell navigationShell,
}) {
  final controller = AppController.instance;
  controller.updateBottomNavIndex(navigationShell.currentIndex);

  return CustomPlatformNavBar(
    currentIndex: controller.currentBottomNavIndex,
    itemChanged: (index) {
      controller.handleBottomNavItemChanged(
        index: index,
        navigationShell: navigationShell,
      );
    },
    material3: (context, platform) {
      return MaterialNavigationBarData(
        indicatorColor: context.colors.secondaryContainer,
        labelBehavior: context.width < 600
            ? NavigationDestinationLabelBehavior.alwaysShow
            : NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: context.colors.surface,
        items: controller.bottomNavItems
            .mapWithIndex(
              (index, item) => CustomNavigationDestination(
                icon: item.iconWidget ??
                    item.icon.buildIconWidget(
                      color: controller.currentBottomNavIndex == index
                          ? context.colors.onSecondaryContainer
                          : context.colors.subtitleTextColor,
                    ),
                label: item.label.tr(context: context),
              ),
            )
            .toList(),
      );
    },
    cupertino: (context, _) {
      return CupertinoTabBarData(
        activeColor: context.colors.primary,
        backgroundColor: PlayxPlatform.isCupertino
            ? context.colors.surfaceContainerHigh.withAlpha(200)
            : null,
        items: controller.bottomNavItems
            .mapWithIndex(
              (index, item) => BottomNavigationBarItem(
                icon: item.iconWidget ??
                    item.icon.buildIconWidget(
                      color: controller.currentBottomNavIndex == index
                          ? context.colors.primary
                          : context.colors.subtitleTextColor,
                      size: PlayxPlatform.isCupertino ? 20 : null,
                    ),
                label: item.label.tr(context: context),
              ),
            )
            .toList(),
      );
    },
  );
}
