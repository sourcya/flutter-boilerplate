part of '../../imports/settings_imports.dart';

class BuildSettingsTermsWidget extends GetView<SettingsController> {
  const BuildSettingsTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildSettingsTile(
      title: AppTrans.termsConditions,
      subtitle: AppTrans.viewTermsConditions,
      icon: Icons.description_outlined,
      onTap: () => PlayxNavigation.toNamed(Routes.termsConditions),
    );
  }
}
