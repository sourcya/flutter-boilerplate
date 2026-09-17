part of '../../../imports/settings_imports.dart';

/// Landscape theme picker: three equal columns with 24px gap (Figma Preferences).
class WebThemeSelectorWidget extends StatelessWidget {
  const WebThemeSelectorWidget({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: controller.selectedTheme,
      builder: (context, selected, _) {
        return ThemeModeSelectorWidget(
          selectedTheme: selected,
          onThemeSelected: (mode) => controller.selectTheme(mode, context: context),
        );
      },
    );
  }
}

class WebThemePreview extends StatelessWidget {
  const WebThemePreview({super.key, required this.mode});

  final ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    return switch (mode) {
      ThemeMode.system => ThemeOption.system.previewWidget,
      ThemeMode.light => ThemeOption.light.previewWidget,
      ThemeMode.dark => ThemeOption.dark.previewWidget,
    };
  }
}
