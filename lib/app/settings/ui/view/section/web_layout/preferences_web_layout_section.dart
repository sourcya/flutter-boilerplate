part of '../../../imports/settings_imports.dart';

class PreferencesWebLayoutSection extends GetView<SettingsController> {
  const PreferencesWebLayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: WebSettingsSectionColumnWidget(
        children: [
          const _PreferencesSectionHeader(
            title: AppTrans.preferences,
            subtitle: AppTrans.preferencesSubtitle,
          ),
          const BuildSettingsDivider(),
          AccountSettingRow(
            icon: Assets.icons.icTheme.toSvgIconInfo(),
            title: AppTrans.interfaceTheme,
            subtitle: AppTrans.themeSubtitle,
            contentLayout: AccountSettingRowContentLayout.intrinsic,
            crossAxisAlignment: CrossAxisAlignment.start,
            content: WebThemeSelectorWidget(controller: controller),
          ),
          const BuildSettingsDivider(),
          AccountSettingRow(
            icon: Assets.icons.language.toSvgIconInfo(),
            title: AppTrans.language,
            subtitle: AppTrans.languageSubtitle,
            contentLayout: AccountSettingRowContentLayout.intrinsic,
            content: const WebLanguageSelectorWidget(),
          ),
        ],
      ),
    );
  }
}

class _PreferencesSectionHeader extends StatelessWidget {
  const _PreferencesSectionHeader({
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
