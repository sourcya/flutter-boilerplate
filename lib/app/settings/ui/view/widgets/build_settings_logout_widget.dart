part of '../../imports/settings_imports.dart';

class BuildSettingsLogOutWidget extends GetView<SettingsController> {
  const BuildSettingsLogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: AppTrans.logout,
      icon: Icons.logout,
      onTap: controller.handleLogOutTap,
    );
  }
}
