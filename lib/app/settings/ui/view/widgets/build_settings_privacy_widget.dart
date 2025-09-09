part of '../../imports/settings_imports.dart';

class BuildSettingsPrivacyWidget extends GetView<SettingsController> {
  const BuildSettingsPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildSettingsTile(
      title: AppTrans.privacyPolicy,
      subtitle: AppTrans.viewPrivacyPolicy,
      icon: Icons.privacy_tip_outlined,
      onTap: () => PlayxNavigation.toNamed(Routes.privacyPolicy),
    );
  }
}
