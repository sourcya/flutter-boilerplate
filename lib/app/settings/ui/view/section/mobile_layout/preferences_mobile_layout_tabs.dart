part of '../../../imports/settings_imports.dart';

class PreferencesMobileLayoutTab extends GetView<SettingsController> {
  const PreferencesMobileLayoutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: 16.hBox),
        const SliverToBoxAdapter(
          child: SettingsSectionHeader(title: AppTrans.interfaceTheme),
        ),
        SliverPadding(
          padding: context.paddingSymmetric(horizontal: 16),
          sliver: const SliverToBoxAdapter(
            child: MobilePreferencesThemeSection(),
          ),
        ),
        SliverToBoxAdapter(child: 16.hBox),
        const SliverToBoxAdapter(
          child: SettingsSectionHeader(title: AppTrans.general),
        ),
        SliverPadding(
          padding: context.paddingSymmetric(horizontal: 16),
          sliver: const SliverToBoxAdapter(
            child: MobilePreferencesGeneralSection(),
          ),
        ),
        SliverToBoxAdapter(child: 32.hBox),
      ],
    );
  }
}
