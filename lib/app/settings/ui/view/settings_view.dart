part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildSettingsLanguageWidget(),
        BuildSettingsThemeWidget(),
        BuildSettingsLogOutWidget(),
        KeyboardVisibilityPadding(),
      ],
    );
  }
}
