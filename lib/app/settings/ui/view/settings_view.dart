part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayxThemeSwitchingArea(
      child: CustomScaffold(
        title: AppTrans.settings,
        leading: AppBarLeadingType.drawerOrRail,
        backgroundColor: context.colors.surface,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 8.0.r),
                  const BuildSettingsLanguageWidget(),
                  const BuildSettingsThemeWidget(),
                  const BuildSettingsPrivacyWidget(),
                  const BuildSettingsTermsWidget(),
                  const BuildSettingsLogOutWidget(),
                  SizedBox(height: 16.0.r),
                ],
              ),
            ),
          ],
        ),
      ),
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
