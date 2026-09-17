part of '../../../imports/app_imports.dart';

class DrawerCollapsedNavigationItem extends StatelessWidget {
  final CustomNavigationDestinationItem item;
  final StatefulNavigationShell navigationShell;
  final bool isSelected;
  final bool isWideWeb;

  const DrawerCollapsedNavigationItem({
    super.key,
    required this.item,
    required this.navigationShell,
    this.isSelected = false,
    this.isWideWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AppController.instance;

    return Builder(
      builder: (anchorContext) => BuildDrawerItemWidget(
        item: item,
        isWideWeb: isWideWeb,
        isSelected: isSelected,
        isExpanded: false,
        onTap: () => controller.openDrawerCollapsedItemMenu(
          anchorContext: anchorContext,
          item: item,
          navigationShell: navigationShell,
        ),
      ),
    );
  }
}
