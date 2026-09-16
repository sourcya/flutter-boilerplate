part of '../imports/settings_imports.dart';

class SettingsView extends CustomOrientationWidget {
  const SettingsView({super.isInitialized, super.key});

  SettingsController get controller => Get.find<SettingsController>();

  void _onPop(BuildContext context, bool didPop) {
    if (didPop || kIsWeb) return;
    if (controller.selectedSettingsTab.value != SettingsTabs.account) {
      controller.selectedSettingsTab.value = SettingsTabs.account;
      return;
    }
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    AppNavigation.navigateToHome();
  }

  @override
  Widget buildPortrait(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onPop(context, didPop),
      child: SettingsMobileView(isInitialized: isInitialized),
    );
  }

  @override
  Widget buildLandscape(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onPop(context, didPop),
      child: SettingsWebLayout(isInitialized: isInitialized),
    );
  }

  static SliverWoltModalSheetPage buildSettingsModalSheetPage(
    SettingsController controller,
    BuildContext context,
  ) {
    return CustomModal.buildCustomModalPage(
      title: AppTrans.settings,
      body: const SettingsMobileView(),
      onClosePressed: controller.closeSettingsModalSheet,
      context: context,
    );
  }
}
