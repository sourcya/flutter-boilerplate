part of '../../../imports/settings_imports.dart';

class WebLanguageSelectorWidget extends GetView<SettingsController> {
  const WebLanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.currentLanguage.value;

      return RadioOptionChips<XLocale>(
        groupValue: selected,
        onChanged: (locale) => controller.handleLanguageSelection(locale, context),
        options: [
          for (final locale in controller.supportedLocales)
            RadioOptionChipData<XLocale>(
              value: locale,
              label: locale.name,
              font: fontFamilyBasedOnText(locale.name, isTranslatable: false),
            ),
        ],
      );
    });
  }
}
