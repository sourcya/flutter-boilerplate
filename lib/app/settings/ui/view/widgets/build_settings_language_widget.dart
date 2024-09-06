part of '../../imports/settings_imports.dart';

class BuildSettingsLanguageWidget extends GetView<SettingsController> {
  const BuildSettingsLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BuildSettingsTile(
        title: AppTrans.language,
        subtitle: controller.currentLocale.value?.name ?? '',
        icon: Icons.language,
        onTap: () {
          controller.showSettingsModalPageSheet(
            context,
            buildModalPage(controller: controller, context: context),
          );
        },
      );
    });
  }

  static SliverWoltModalSheetPage buildModalPage({
    required SettingsController controller,
    required BuildContext context,
    bool isOnlyPage = true,
  }) {
    return BuildSettingsPage.buildModalPage(
      title: AppTrans.language,
      items: controller.supportedLocales,
      onItemSelected: (lang) => controller.handleLanguageSelection(lang),
      itemName: (lang) => lang.name,
      isItemSelected: (lang) => controller.currentLocale.value == lang,
      onBackButtonPressed: isOnlyPage
          ? null
          : () {
              controller.currentPage.value = SettingsPage.settings.index;
            },
      showPreviousButton: !isOnlyPage,
      onCloseButtonPressed: controller.closeSettingsModalSheet,
      context: context,
    );
  }
}
