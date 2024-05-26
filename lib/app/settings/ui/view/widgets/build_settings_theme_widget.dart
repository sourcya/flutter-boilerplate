part of '../../imports/settings_imports.dart';

class BuildSettingsThemeWidget extends GetView<SettingsController> {
  const BuildSettingsThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BuildSettingsTile(
        title: AppTrans.theme,
        subtitle: controller.currentTheme.value.name,
        icon: Icons.dark_mode_rounded,
        onTap: () {
          controller.showSettingsModalPageSheet(
            context,
            buildModalPage(controller, context),
          );
        },
      );
    });
  }

  static SliverWoltModalSheetPage buildModalPage(
    SettingsController controller,
    BuildContext context,
  ) {
    return BuildSettingsPage.buildModalPage(
      title: AppTrans.theme,
      items: PlayxTheme.supportedThemes,
      onItemSelected: (theme) =>
          controller.handleThemeSelection(theme, context: context),
      itemName: (theme) => theme.name.tr(context: context),
      isItemSelected: (theme) => controller.currentTheme.value.id == theme.id,
      onCloseButtonPressed: controller.closeSettingsModalSheet,
      onBackButtonPressed: () {
        controller.currentPage.value = SettingsPage.settings.index;
      },
      context: context,
      showPreviousButton: true,
    );
  }
}
