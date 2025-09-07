part of '../../imports/settings_imports.dart';

class BuildSettingsPrivacyWidget extends GetView<SettingsController> {
  const BuildSettingsPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildSettingsTile(
      title: AppTrans.privacyPolicy,
      subtitle: AppTrans.viewPrivacyPolicy,
      icon: Icons.privacy_tip_outlined,
      onTap: () {
        // if (controller.currentPage.value == SettingsPage.settings.index) {
        //   // Navigate to Privacy Policy
        //   controller.showSettingsModalPageSheet(
        //     context,
        //     _buildPrivacyPolicyModalPage(context),
        //   );
        // } else {
        //   PlayxNavigation.toNamed(Routes.privacyPolicy);
        // }
        PlayxNavigation.toNamed(Routes.privacyPolicy);
      },
    )
        /* .animate()
        .fadeIn(duration: 500.ms, delay: 200.ms)
        .slideX(begin: -0.1, end: 0, duration: 500.ms) */;
  }

  static SliverWoltModalSheetPage _buildPrivacyPolicyModalPage(
      BuildContext context) {
    return CustomModal.buildCustomModalPage(
      title: AppTrans.privacyPolicy,
      body: const PrivacyPolicyView(isModal: true),
      onClosePressed: () => PlayxNavigation.pop(),
      context: context,
    );
  }
}
