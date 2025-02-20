part of '../../imports/app_imports.dart';

class CustomNavigationRail extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationRail({required this.navigationShell, super.key});

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    controller.updateDrawerIndex(navigationShell.currentIndex);
    return NavigationRail(
      selectedIndex: controller.currentDrawerIndex,
      onDestinationSelected: (index) {
        controller.handleDrawerItemChanged(
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
