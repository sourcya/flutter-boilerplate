part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 8.0.r),
              const BuildSettingsLanguageWidget(),
              const BuildSettingsThemeWidget(),
              SizedBox(height: 16.0.r),
              // const BuildSettingsLogOutWidget(),
            ],
          ),
        ),
      ],
    );
  }

  static SliverWoltModalSheetPage buildSettingsModalSheetPage(
    SettingsController controller,
    BuildContext context,
  ) {
    return CustomModal.buildCustomModalPage(
      title: AppTrans.settings,
      body: const SettingsView(),
      onClosePressed: controller.closeSettingsModalSheet,
      context: context,
    );
  }
}
