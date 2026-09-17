part of '../../../imports/app_imports.dart';

class _DrawerFooterActionTile extends StatelessWidget {
  final CustomNavigationDestinationItem item;
  final void Function(BuildContext context)? onTap;
  final Color? color;

  const _DrawerFooterActionTile({
    required this.item,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BuildDrawerItemWidget(
      item: item,
      onTap: () => onTap?.call(context),
      color: color,
      padding: context.paddingSymmetric(horizontal: 8, vertical: 12),
      borderRadius: 16,
    );
  }
}

class BuildDrawerFooterWidget extends StatelessWidget {
  final bool isWideWeb;
  final bool showExpandedProfile;
  final StatefulNavigationShell navigationShell;
  const BuildDrawerFooterWidget({
    super.key,
    required this.showExpandedProfile,
    required this.navigationShell,
    this.isWideWeb = false,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdvancedDrawerValue>(
      valueListenable: controller.drawerController,
      builder: (context, value, _) {
        final bool isExpanded = value.visible;
        final isPortraitDrawer = !isWideWeb && context.isAppPortrait;

        if (isPortraitDrawer) {
          return Padding(
            padding: context.paddingOnly(top: 8, start: 8, end: 8, bottom: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SupportButton(
                  size: 40,
                  isShowLabel: true,
                ),
                for (final item in controller.otherDrawerItems.skip(1)) ...[
                  8.hBox,
                  _DrawerFooterActionTile(
                    item: item,
                    color: item.label == AppTrans.logout ? AppColors.destructive : null,
                    onTap: (anchorContext) {
                      controller.handleDrawerOtherItemClicked(
                        item: item,
                        context: anchorContext,
                        navigationShell: navigationShell,
                      );
                      HapticFeedback.selectionClick();
                    },
                  ),
                ],
                const _DrawerBodyVersionFooter(isExpanded: true),
              ],
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isWideWeb && !isExpanded)
              const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SupportButton(size: 36, isShowLabel: true, isExpanded: false),
                  DrawerBodyUserProfileSection(isExpanded: false),
                ],
              )
            else if (isWideWeb && isExpanded)
              Padding(
                padding: context.paddingAll(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8.0.r,
                  children: const [
                    SupportButton(size: 36, isShowLabel: true),
                    DrawerBodyUserProfileSection(isExpanded: true),
                    _DrawerBodyVersionFooter(isExpanded: true),
                  ],
                ),
              )
            else ...[
              Divider(
                color: context.colors.border.withValues(alpha: .4),
                thickness: 1,
                indent: 8.r,
                endIndent: 8.r,
              ),
              SupportButton(
                size: isExpanded ? 40 : 32,
                isShowLabel: isExpanded,
                isExpanded: isExpanded,
              ).paddingOnly(top: 8.0.r),
              if (!isWideWeb)
                for (final item in controller.otherDrawerItems.skip(1))
                  BuildDrawerItemWidget(
                    item: item,
                    isExpanded: isExpanded,
                    color: context.colors.statusInactiveColor,
                    onTap: () {
                      controller.handleDrawerOtherItemClicked(
                        item: item,
                        context: context,
                        navigationShell: navigationShell,
                      );
                      HapticFeedback.selectionClick();
                    },
                  ),
              (isWideWeb ? 8.0 : 24.0).hBox,
            ],
          ],
        );
      },
    );
  }
}
