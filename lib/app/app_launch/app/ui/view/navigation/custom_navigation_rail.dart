part of '../../imports/app_imports.dart';

class CustomNavigationRail extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationRail({required this.navigationShell, super.key});

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    controller.updateDrawerIndex(navigationShell.currentIndex);
    return NavigationRail(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) {
        AppNavigation.goToBranch(
          index: index,
          navigationShell: navigationShell,
        );
      },
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard_outlined),
          label: CustomText(
            AppTrans.dashboard,
            isResponsive: false,
          ),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          label: CustomText(
            AppTrans.settings,
            isResponsive: false,
          ),
        ),
      ],
    );
  }
}
