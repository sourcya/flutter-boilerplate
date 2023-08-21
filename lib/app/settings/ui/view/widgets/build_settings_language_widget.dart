part of '../../imports/settings_imports.dart';

class BuildSettingsLanguageWidget extends GetView<SettingsController> {
  const BuildSettingsLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BuildSettingsTile(
        title: AppTrans.language.tr,
        subtitle: controller.currentLocale.value?.name ?? '',
        icon: Icons.language,
        onTap: () {
          Get.dialog(
            BuildSettingsDialog(
              title: AppTrans.language.tr,
              items: controller.supportedLocales,
              onItemSelected: (lang) =>
                  controller.handleLanguageSelection(lang),
              itemName: (lang) => lang.name,
              isItemSelected: (lang) => controller.currentLocale.value == lang,
            ),
          );
        },
      );
    });
  }
}
