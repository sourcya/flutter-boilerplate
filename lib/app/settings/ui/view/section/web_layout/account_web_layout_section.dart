part of '../../../imports/settings_imports.dart';

class AccountWebLayoutSection extends GetView<SettingsController> {
  const AccountWebLayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: WebSettingsSectionColumnWidget(
        children: [
          const _AccountSectionHeader(
            title: AppTrans.account,
            subtitle: AppTrans.accountSubtitle,
          ),
          const BuildSettingsDivider(),
          WebSettingsSectionColumnWidget(
            children: [
              AccountSettingRow(
                icon: Assets.icons.icUser.toSvgIconInfo(),
                title: AppTrans.username,
                subtitle: AppTrans.usernameSubtitle,
                content: Obx(() {
                  return WebSettingsReadOnlyFieldWidget(
                    value: controller.signedInUser.value?.username ?? '-',
                  );
                }),
              ),
              AccountSettingRow(
                icon: Assets.icons.icEmail.toSvgIconInfo(),
                title: AppTrans.email,
                subtitle: AppTrans.emailSubtitle,
                content: Obx(() {
                  return WebSettingsReadOnlyFieldWidget(
                    value: controller.signedInUser.value?.email ?? '-',
                  );
                }),
              ),
              Obx(() {
                final phoneNumber = AppController
                    .instance.currentSubscription.value?.phoneNumber;
                return AnimatedVisibility(
                  isVisible: phoneNumber != null && phoneNumber.isNotEmpty,
                  child: AccountSettingRow(
                    icon: Assets.icons.icPhone.toSvgIconInfo(),
                    title: AppTrans.phoneTitle,
                    subtitle: AppTrans.phoneNumberSubtitle,
                    content: WebSettingsReadOnlyFieldWidget(
                      value: phoneNumber ?? 'N/A',
                    ),
                  ),
                );
              }),
              AccountSettingRow(
                icon: Assets.icons.icLock.toSvgIconInfo(),
                title: AppTrans.password,
                subtitle: AppTrans.passwordSubtitle,
                content: Row(
                  children: [
                    const Expanded(
                      child: WebSettingsReadOnlyFieldWidget(value: '*********'),
                    ),
                    8.wBox,
                    _AccountChangePasswordButton(
                      onTap: () =>
                          controller.showChangePasswordDialog(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const BuildSettingsDivider(),
          AccountSettingRow(
            icon: Assets.icons.badgeCheck.toSvgIconInfo(),
            title: AppTrans.subscription,
            subtitle: AppTrans.subscriptionSubtitle,
            content: Obx(() {
              final subscription =
                  AppController.instance.currentSubscription.value;
              return AccountSubscriptionCard(subscription: subscription);
            }),
          ),
          32.hBox,
        ],
      ),
    );
  }
}

class _AccountSectionHeader extends StatelessWidget {
  const _AccountSectionHeader({
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

class _AccountChangePasswordButton extends StatelessWidget {
  const _AccountChangePasswordButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppTrans.changePasswordTitle.tr(),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            constraints: BoxConstraints(minWidth: 80.r),
            padding: context.paddingSymmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: context.colors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: CustomText(
              AppTrans.change,
              textStyle: context.labelLargeTS.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.71,
                color: context.colors.primaryActionText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
