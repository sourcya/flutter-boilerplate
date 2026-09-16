part of '../../../imports/settings_imports.dart';

class MobilePreferencesGeneralSection extends GetView<SettingsController> {
  const MobilePreferencesGeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsListContainer(
      padding: EdgeInsets.zero,
      children: [
        Obx(
          () => SettingsPickerRow(
            title: AppTrans.language,
            svgIcon: Assets.icons.language,
            valueLabel:
                controller.currentLanguage.value?.name.tr(context: context) ??
                '',
            onTap: () => LanguagePickerSheetContent.show(
              context: context,
              controller: controller,
            ),
          ),
        ),
      ],
    );
  }
}

class LanguagePickerSheetContent extends StatelessWidget {
  const LanguagePickerSheetContent({super.key, required this.controller});

  final SettingsController controller;

  static Future<void> show({
    required BuildContext context,
    required SettingsController controller,
  }) {
    return PickerBottomSheet.show(
      context: context,
      icon: IconInfo.icon(
        Icons.language,
        color: context.colors.primaryActionText,
      ),
      title: AppTrans.language,
      child: LanguagePickerSheetContent(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.supportedLocales.map((language) {
          final isSelected =
              controller.currentLanguage.value?.id == language.id;
          return PickerBottomSheetOption(
            label: language.name,
            isSelected: isSelected,
            font: fontFamilyBasedOnText(language.name),
            onTap: () {
              controller.handleLanguageSelection(language);
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}
