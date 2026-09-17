part of '../../../imports/app_imports.dart';

class DrawerExpandableSubItemsList extends StatelessWidget {
  final List<CustomNavigationSubItem> subItems;
  final StatefulNavigationShell navigationShell;

  const DrawerExpandableSubItemsList({
    super.key,
    required this.subItems,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final controller = AppController.instance;
    final usesLightDrawerChrome = !context.isDarkMode && context.isAppPortrait;
    final bracketColor = usesLightDrawerChrome
        ? context.colors.border
        : context.colors.sidebarForeground.withValues(alpha: 0.22);

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: scale.r(32),
        end: scale.r(8),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: BorderDirectional(
            start: BorderSide(color: bracketColor),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: scale.r(2),
            bottom: scale.r(2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final sub in subItems)
                DrawerExpandableSubItemRow(
                  label: sub.label,
                  isSelected: controller.isSubItemSelected(sub),
                  onTap: () => controller.handleDrawerSubItemTapFromUi(
                    subItem: sub,
                    navigationShell: navigationShell,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
