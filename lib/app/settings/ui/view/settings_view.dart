part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: AppTrans.settings.tr),
      body: const OptimizedScrollView(
        child: Column(
          children: [
            BuildSettingsLanguageWidget( ),
            BuildSettingsThemeWidget(),
          ],
        ),
      ),
    );
  }
}
