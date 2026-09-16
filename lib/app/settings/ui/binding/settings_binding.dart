part of '../imports/settings_imports.dart';

class SettingsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (Get.isRegistered<SettingsController>()) {
      Get.delete<SettingsController>();
    }
    SettingsTabs? initialTab;
    final tabName = state.uri.queryParameters['tab'];
    if (tabName != null) {
      for (final tab in SettingsTabs.values) {
        if (tab.name == tabName) {
          initialTab = tab;
          break;
        }
      }
    }
    Get.put(SettingsController(initialTab: initialTab));
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    Get.delete<SettingsController>();
  }
}
