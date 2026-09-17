part of '../../../imports/app_imports.dart';

class DrawerNavigationItemView extends StatelessWidget {
  final CustomNavigationDestinationItem item;
  final StatefulNavigationShell navigationShell;
  final bool isExpanded;
  final bool isWideWeb;
  final int fallbackIndex;

  const DrawerNavigationItemView({
    super.key,
    required this.item,
    required this.navigationShell,
    required this.isExpanded,
    required this.isWideWeb,
    required this.fallbackIndex,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AppController.instance;
    final isSelected = controller.isDrawerItemSelected(item, navigationShell);

    if (item.isExpandable) {
      final isCollapsedRail = isWideWeb && !isExpanded;
      if (isCollapsedRail) {
        return DrawerCollapsedNavigationItem(
          item: item,
          navigationShell: navigationShell,
          isSelected: isSelected,
          isWideWeb: isWideWeb,
        );
      }
      return DrawerExpandableNavigationItem(
        item: item,
        navigationShell: navigationShell,
        isExpanded: isExpanded,
        isSelected: isSelected,
        initiallyExpanded: isSelected,
        isWideWeb: isWideWeb,
      );
    }

    return BuildDrawerItemWidget(
      item: item,
      isWideWeb: isWideWeb,
      isSelected: isSelected,
      isExpanded: isExpanded,
      onTap: () {
        if (item.navigationIndex == null && item.route == null) {
          controller.handleDrawerMainItemClicked(
            index: fallbackIndex,
            navigationShell: navigationShell,
          );
          return;
        }
        controller.handleDrawerItemTap(
          item: item,
          navigationShell: navigationShell,
        );
      },
    );
  }
}
