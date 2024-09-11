part of '../imports/custom_navigation_drawer_imports.dart';

class CustomNavigationRail extends GetView<CustomNavigationDrawerController> {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationRail({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    controller.updateIndex(navigationShell.currentIndex);
    return NavigationRail(
      selectedIndex: controller.currentIndex,
      onDestinationSelected: (index) {
        controller.handleItemChanged(
          index: index,
          navigationShell: navigationShell,
        );
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.home),
          label: Text(AppTrans.dashboard.tr(context: context)),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.favorite_border),
          label: Text(AppTrans.wishlist.tr(context: context)),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.settings),
          label: Text(AppTrans.settings.tr(context: context)),
        ),
      ],
    );
  }
}
