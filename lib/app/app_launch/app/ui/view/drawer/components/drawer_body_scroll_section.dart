part of '../../../imports/app_imports.dart';

class BuildDrawerBodyWidget extends StatelessWidget {
  final bool isWideWeb;
  final StatefulNavigationShell navigationShell;
  const BuildDrawerBodyWidget({
    super.key,
    this.isWideWeb = false,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpanded = AppController.instance.drawerController.value.visible;
    final isPortraitDrawer = !isWideWeb && context.isAppPortrait;
    final useLightDrawerChrome = !context.isDarkMode && (isWideWeb || isPortraitDrawer);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: isWideWeb
                  ? context.paddingAll(8)
                  : (isPortraitDrawer
                        ? context.paddingSymmetric(horizontal: 8)
                        : context.paddingZero()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isWideWeb || isExpanded)
                    Padding(
                      padding: context.paddingSymmetric(horizontal: 8, vertical: 6),
                      child: CustomText(
                        AppTrans.main,
                        textStyle: context.styles.textXsSemibold.copyWith(
                          color: useLightDrawerChrome
                              ? context.colors.foreground.withValues(alpha: 0.7)
                              : context.colors.sidebarForeground70,
                          fontWeight: FontWeight.w600,
                          height: 1.67,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Obx(() {
                      final controller = AppController.instance;
                      controller.activeAppModules.length;
                      controller.moduleDrawerItems.length;
                      controller.currentDrawerIndex.value;

                      final mainItems = controller.mainDrawerItems.toList();
                      final moduleItems = controller.moduleDrawerItems.toList();

                      final children = <Widget>[];
                      for (int i = 0; i < mainItems.length; i++) {
                        final item = mainItems[i];
                        children.add(
                          DrawerNavigationItemView(
                            item: item,
                            navigationShell: navigationShell,
                            isExpanded: isExpanded,
                            isWideWeb: isWideWeb,
                            fallbackIndex: i,
                          ),
                        );
                      }

                      if (moduleItems.isNotEmpty) {
                        children.add(
                          _DrawerModulesDivider(
                            isExpanded: isExpanded,
                            isWideWeb: isWideWeb,
                          ),
                        );
                        if (!isWideWeb || isExpanded) {
                          children.add(
                            Padding(
                              padding: context.paddingSymmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              child: CustomText(
                                AppTrans.activeModulesTitle,
                                textStyle: context.styles.textXsSemibold.copyWith(
                                  color: useLightDrawerChrome
                                      ? context.colors.foreground.withValues(
                                          alpha: 0.7,
                                        )
                                      : context.colors.sidebarForeground70,
                                  fontWeight: FontWeight.w600,
                                  height: 1.67,
                                ),
                              ),
                            ),
                          );
                        }
                        for (int i = 0; i < moduleItems.length; i++) {
                          children.add(
                            DrawerNavigationItemView(
                              item: moduleItems[i],
                              navigationShell: navigationShell,
                              isExpanded: isExpanded,
                              isWideWeb: isWideWeb,
                              fallbackIndex:
                                  moduleItems[i].navigationIndex ?? i,
                            ),
                          );
                        }
                      }

                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(children),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerModulesDivider extends StatelessWidget {
  const _DrawerModulesDivider({
    required this.isExpanded,
    required this.isWideWeb,
  });

  final bool isExpanded;
  final bool isWideWeb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnly(start: 8, top: 10, end: 8, bottom: 4),
      child: Divider(
        height: 1,
        color: (!isExpanded && isWideWeb)
            ? context.colors.sidebarRailDivider
            : context.colors.sidebarForeground.withValues(alpha: .12),
      ),
    );
  }
}
