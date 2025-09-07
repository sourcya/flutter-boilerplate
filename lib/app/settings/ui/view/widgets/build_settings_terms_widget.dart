part of '../../imports/settings_imports.dart';

class BuildSettingsTermsWidget extends GetView<SettingsController> {
  const BuildSettingsTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildSettingsTile(
      title: AppTrans.termsConditions,
      subtitle: AppTrans.viewTermsConditions,
      icon: Icons.description_outlined,
      onTap: () {
        // if (controller.currentPage.value == SettingsPage.settings.index) {
        //   // Navigate to Terms & Conditions
        //   controller.showSettingsModalPageSheet(
        //     context,
        //     _buildTermsModalPage(context),
        //   );
        // } else {
        //   PlayxNavigation.toNamed(Routes.termsConditions);
        // }
          PlayxNavigation.toNamed(Routes.termsConditions);
      },
    )/* .animate()
      .fadeIn(duration: 500.ms, delay: 300.ms)
      .slideX(begin: -0.1, end: 0, duration: 500.ms) */;
  }

  static SliverWoltModalSheetPage _buildTermsModalPage(BuildContext context) {
    return CustomModal.buildCustomModalPage(
      title: AppTrans.termsConditions,
      body: const TermsConditionsView(isModal: true),
      onClosePressed: () => PlayxNavigation.pop(),
      context: context,
    );
  }
}
