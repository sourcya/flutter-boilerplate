part of '../imports/custom_navigation_drawer_imports.dart';

class CustomNavigationDrawer extends GetView<CustomNavigationDrawerController> {
  final StatefulNavigationShell navigationShell;

  const CustomNavigationDrawer({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    controller.updateIndex(navigationShell.currentIndex);

    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: controller.currentIndex,
        indicatorColor: context.colors.primary,
        onDestinationSelected: (index) {
          controller.handleItemChanged(
              index: index, navigationShell: navigationShell);
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
            color: context.colors.onSurface.withOpacity(.3),
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
    final isSelected = navigationShell.currentIndex == index;
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
