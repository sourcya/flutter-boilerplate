part of '../../../imports/settings_imports.dart';

class AccountMobileLayoutTab extends GetView<SettingsController> {
  const AccountMobileLayoutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: 16.hBox),
        const SliverToBoxAdapter(
          child: SettingsSectionHeader(title: AppTrans.accountInformation),
        ),
        SliverPadding(
          padding: context.paddingSymmetric(horizontal: 16),
          sliver: const SliverToBoxAdapter(child: _AccountInfoList()),
        ),
        SliverToBoxAdapter(child: 16.hBox),
        const SliverToBoxAdapter(
          child: SettingsSectionHeader(title: AppTrans.subscription),
        ),
        SliverPadding(
          padding: context.paddingSymmetric(horizontal: 16),
          sliver: const SliverToBoxAdapter(child: _SubscriptionCard()),
        ),
        SliverToBoxAdapter(child: 32.hBox),
      ],
    );
  }
}

class _AccountInfoList extends GetView<SettingsController> {
  const _AccountInfoList();

  @override
  Widget build(BuildContext context) {
    return SettingsListContainer(
      children: [
        Obx(() {
          return SettingsTile(
            title: controller.signedInUser.value?.username ?? '-',
            label: AppTrans.username,
            svgIcon: Assets.icons.icUser,
            onTap: null,
            showDivider: true,
            isSubtitleTranslatable: false,
          );
        }),
        Obx(() {
          return SettingsTile(
            title: controller.signedInUser.value?.email ?? '-',
            label: AppTrans.email,
            svgIcon: Assets.icons.icEmail,
            onTap: null,
            showDivider: true,
            isSubtitleTranslatable: false,
          );
        }),
        Obx(() {
          final phoneNumber =
              AppController.instance.currentSubscription.value?.phoneNumber;
          if (phoneNumber == null || phoneNumber.isEmpty) {
            return const SizedBox.shrink();
          }
          return SettingsTile(
            title: phoneNumber,
            label: AppTrans.phoneTitle,
            svgIcon: Assets.icons.icPhone,
            onTap: null,
            showDivider: true,
            isSubtitleTranslatable: false,
          );
        }),
        SettingsTile(
          title: '************',
          label: AppTrans.password,
          svgIcon: Assets.icons.icLock,
          onTap: null,
          actionButtonText: AppTrans.change,
          onActionButtonTap: () => controller.showChangePasswordDialog(context),
        ),
      ],
    );
  }
}

class _SubscriptionCard extends GetView<SettingsController> {
  const _SubscriptionCard();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subscription = AppController.instance.currentSubscription.value;
      return AccountSubscriptionCard(subscription: subscription);
    });
  }
}
