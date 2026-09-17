part of '../imports/settings_imports.dart';

class SettingsWebLayout extends GetView<SettingsController> {
  final bool isInitialized;

  const SettingsWebLayout({
    super.key,
    this.isInitialized = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedTab = controller.selectedSettingsTab.value;
      return SidePanelLayoutView<SettingsTabs>(
        isInitialized: isInitialized,
        title: AppTrans.settings,
        attachBreadcrumb: true,
        sideRowPadding: context.paddingSymmetric(vertical: 16),
        breadcrumbs: [
          BreadcrumbItem(
            title: AppTrans.settings,
            onTap: () =>
                controller.selectedSettingsTab.value = SettingsTabs.account,
          ),
          BreadcrumbItem(title: selectedTab.title),
        ],
        items: SettingsTabs.visibleTabs,
        selectedItem: controller.selectedSettingsTab,
        sideItemBuilder: (ctx, tab, isSelected) {
          return Container(
            width: ctx.width,
            padding: ctx.paddingSymmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: isSelected ? ctx.colors.primary : null,
              shape: RoundedRectangleBorder(borderRadius: 12.0.radius),
              shadows: isSelected
                  ? [
                      BoxShadow(
                        color: ctx.colors.toggleShadowColor,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                IconInfo.svg(tab.icon).buildIconWidget(
                  size: 16.r,
                  color: isSelected
                      ? ctx.colors.primaryActionText
                      : ctx.colors.foreground,
                ),
                6.wBox,
                Expanded(
                  child: CustomText(
                    tab.title.tr(context: ctx),
                    isTranslatable: false,
                    textStyle: ctx.labelLargeTS.copyWith(
                      color: isSelected
                          ? ctx.colors.primaryActionText
                          : ctx.colors.foreground,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      height: 1.43,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        contentBuilder: (ctx, tab) {
          return Padding(
            padding: ctx.paddingAll(24),
            child: switch (tab) {
              SettingsTabs.account => const AccountWebLayoutSection(),
              SettingsTabs.preferences => const PreferencesWebLayoutSection(),
              SettingsTabs.notifications =>
                const NotificationsWebLayoutSection(),
              SettingsTabs.activeModules =>
                const ActiveModulesWebLayoutSection(),
            },
          );
        },
      );
    });
  }
}
