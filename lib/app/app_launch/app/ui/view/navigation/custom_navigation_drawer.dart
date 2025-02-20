part of '../../imports/app_imports.dart';

class CustomNavigationDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationDrawer({required this.navigationShell, super.key});

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    controller.updateDrawerIndex(navigationShell.currentIndex);

    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: controller.currentDrawerIndex,
        indicatorColor: context.colors.primary,
        onDestinationSelected: (index) {
          controller.handleDrawerItemChanged(
            index: index,
            navigationShell: navigationShell,
          );
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: CustomText(
              AppTrans.appName,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          buildNavigationDrawerDestination(
            icon: Icons.dashboard,
            label: AppTrans.dashboard,
            context: context,
          ),
          buildNavigationDrawerDestination(
            icon: Icons.favorite_border,
            label: AppTrans.wishlist,
            index: 1,
            context: context,
          ),
          buildNavigationDrawerDestination(
            icon: Icons.settings,
            label: AppTrans.settings,
            index: 2,
            context: context,
          ),
          Divider(
            color: context.colors.onSurface.withAlpha(100),
          ),
          NavigationDrawerDestination(
            icon: const Icon(Icons.logout),
            label: CustomText(AppTrans.logout.tr(context: context)),
          ),
        ],
      ),
    );
  }

  NavigationDrawerDestination buildNavigationDrawerDestination({
    required IconData icon,
    required String label,
    int index = 0,
    required BuildContext context,
  }) {
    final isSelected = controller.currentDrawerIndex == index;
    return NavigationDrawerDestination(
      icon: Icon(
        icon,
        color: isSelected ? context.colors.onPrimary : context.colors.onSurface,
      ),
      label: CustomText(
        label,
        color: isSelected ? context.colors.onPrimary : context.colors.onSurface,
      ),
    );
  }
}
