part of '../imports/settings_imports.dart';

class SettingsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsController());
    }
  }

  @override
  Future<void> onExit(BuildContext context) async {
    // Fimber.d('SettingsBinding Dashboard onEnter');
    // if (Get.isRegistered<SettingsController>()) {
    //   Get.delete<SettingsController>();
    // }
  }
}
