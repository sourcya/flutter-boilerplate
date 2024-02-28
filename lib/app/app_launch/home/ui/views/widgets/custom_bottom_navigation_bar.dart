part of '../../imports/home_imports.dart';

class CustomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationBar({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) {
        AppRouter.goToBranch(index: index, navigationShell: navigationShell);
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home),
          label: AppTrans.dashboard.tr,
        ),
        NavigationDestination(
          icon: const Icon(Icons.favorite_border),
          label: AppTrans.wishlist.tr,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings),
          label: AppTrans.settings.tr,
        ),
      ],
    );
  }
}
