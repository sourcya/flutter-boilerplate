part of '../../imports/settings_imports.dart';

class BuildSettingsThemeWidget extends GetView<SettingsController> {
  const BuildSettingsThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SettingsTile(
        title: AppTrans.theme.tr,
        subtitle: controller.currentTheme.value.name,
        icon: Icons.dark_mode_rounded,
        onTap: () {
          Get.dialog(
            SettingsDialog(
              title: AppTrans.theme.tr,
              items: AppTheme.supportedThemes,
              onItemSelected: (theme) => controller.handleThemeSelection(theme),
              itemName: (theme) => theme.name,
              itemIcon: null,
              isItemSelected: (theme) =>
              controller.currentTheme.value.id == theme.id,
            ),
          );
        },);
    });
  }
}

