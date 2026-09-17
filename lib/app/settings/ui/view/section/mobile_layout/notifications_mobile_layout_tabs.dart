part of '../../../imports/settings_imports.dart';

class NotificationsMobileLayoutTab extends GetView<SettingsController> {
  const NotificationsMobileLayoutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: 16.hBox),
        SliverPadding(
          padding: context.paddingSymmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              MobileNotificationsSettingsSection(controller: controller),
            ]),
          ),
        ),
        SliverToBoxAdapter(child: 32.hBox),
      ],
    );
  }
}

class MobileNotificationsSettingsSection extends StatelessWidget {
  const MobileNotificationsSettingsSection({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return SettingsListContainer(
      padding: EdgeInsets.zero,
      children: [
        Obx(
          () => SettingsSwitchRow(
            title: AppTrans.notifications,
            svgIcon: Assets.icons.bell,
            value: controller.isNotificationsEnabled.value,
            onChanged: controller.toggleNotifications,
            onTap: () => controller.toggleNotifications(
              !controller.isNotificationsEnabled.value,
            ),
            showDivider: true,
          ),
        ),
        Obx(
          () => SettingsSwitchRow(
            title: AppTrans.soundAlerts,
            svgIcon: Assets.icons.volume,
            value: controller.soundAlertsEnabled.value,
            onChanged: controller.toggleSoundAlerts,
            onTap: () => controller.toggleSoundAlerts(
              !controller.soundAlertsEnabled.value,
            ),
          ),
        ),
      ],
    );
  }
}
