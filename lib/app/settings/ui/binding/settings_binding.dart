part of '../imports/settings_imports.dart';

class SettingsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Fimber.d('PlayxRoute Binding Setting onEnter');
    Get.put(SettingsController());
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    Fimber.d('PlayxRoute Binding Setting onExit');
    Get.delete<SettingsController>();
  }
}
