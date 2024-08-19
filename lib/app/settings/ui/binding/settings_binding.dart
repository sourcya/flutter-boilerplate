part of '../imports/settings_imports.dart';

class SettingsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Setting onEnter');
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsController());
    }
  }

  @override
  Future<void> onExit(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Setting onExit');
    // if (Get.isRegistered<SettingsController>()) {
    //   Get.delete<SettingsController>();
    // }
  }
}
