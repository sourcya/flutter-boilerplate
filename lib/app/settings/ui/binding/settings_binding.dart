part of '../imports/settings_imports.dart';

class SettingsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Get.put(SettingsController());
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    // Get.delete<SettingsController>();
  }
}
