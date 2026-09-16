part of '../../../imports/settings_imports.dart';

class NotificationsWebLayoutSection extends GetView<SettingsController> {
  const NotificationsWebLayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: WebSettingsSectionColumnWidget(
        children: [
          const _NotificationsSectionHeader(
            title: AppTrans.notifications,
            subtitle: AppTrans.notificationsSubtitle,
          ),
          const BuildSettingsDivider(),
          AccountSettingRow(
            icon: Assets.icons.bellDot.toSvgIconInfo(),
            title: AppTrans.browserNotifications,
            subtitle: AppTrans.browserNotificationsSubtitle,
            contentLayout: AccountSettingRowContentLayout.intrinsic,
            content: Obx(
              () => CompactAppSwitch(
                value: controller.isNotificationsEnabled.value,
                onChanged: controller.toggleNotifications,
              ),
            ),
          ),
          const BuildSettingsDivider(),
          AccountSettingRow(
            icon: Assets.icons.volume.toSvgIconInfo(),
            title: AppTrans.soundAlerts,
            subtitle: AppTrans.soundAlertsSubtitle,
            contentLayout: AccountSettingRowContentLayout.intrinsic,
            content: Obx(
              () => CompactAppSwitch(
                value: controller.soundAlertsEnabled.value,
                onChanged: controller.toggleSoundAlerts,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsSectionHeader extends StatelessWidget {
  const _NotificationsSectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            textStyle: context.displayMediumTS.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              height: 1.40,
              letterSpacing: -0.6,
              color: context.colors.cardForeground,
            ),
          ),
          6.hBox,
          CustomText(
            subtitle,
            textStyle: context.bodyMediumTS.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.43,
              color: context.colors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
