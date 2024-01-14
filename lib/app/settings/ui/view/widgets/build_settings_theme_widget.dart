part of '../../imports/settings_imports.dart';

class BuildSettingsThemeWidget extends GetView<SettingsController> {
  const BuildSettingsThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BuildSettingsTile(
        title: AppTrans.theme.tr,
        subtitle: controller.currentTheme.value.name.tr,
        icon: Icons.dark_mode_rounded,
        onTap: () {
          Get.dialog(
            BuildSettingsDialog(
              title: AppTrans.theme.tr,
              items: PlayxTheme.supportedThemes,
              onItemSelected: (theme) => controller.handleThemeSelection(theme),
              itemName: (theme) => theme.name.tr,
              isItemSelected: (theme) =>
              controller.currentTheme.value.id == theme.id,
            ),
          );
        },);
    });
  }
}
