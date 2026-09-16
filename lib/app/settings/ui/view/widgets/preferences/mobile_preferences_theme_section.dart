part of '../../../imports/settings_imports.dart';

class MobilePreferencesThemeSection extends GetView<SettingsController> {
  const MobilePreferencesThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: controller.selectedTheme,
      builder: (context, selected, _) {
        return PlayxThemeSwitcher(
          builder: (ctx, _) {
            return ThemeModeSelectorWidget(
              selectorLayout: ThemeModeSelectorLayout.mobile,
              selectedTheme: selected,
              onThemeSelected: (theme) =>
                  controller.selectTheme(theme, context: ctx),
            );
          },
        );
      },
    );
  }
}
