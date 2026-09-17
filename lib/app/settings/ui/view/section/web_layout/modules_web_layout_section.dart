part of '../../../imports/settings_imports.dart';

class ActiveModulesWebLayoutSection extends GetView<SettingsController> {
  const ActiveModulesWebLayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: WebSettingsSectionColumnWidget(
        children: [
          const _ActiveModulesSectionHeader(
            title: AppTrans.activeModulesTitle,
            subtitle: AppTrans.activeModulesDescription,
          ),
          const BuildSettingsDivider(),
          Obx(() {
            final enabledTypes = controller.activeModuleTypes.toList();
            final modules = AppModules.availableModules;

            Widget cardAt(int index) {
              final module = modules[index];
              return _ActiveModuleCard(
                module: module,
                isEnabled: enabledTypes.contains(module.type),
                onToggleChanged: (value) =>
                    controller.toggleModule(module, value),
              );
            }

            if (context.width > 1000) {
              return AlignedGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16.r,
                crossAxisSpacing: 16.r,
                itemCount: modules.length,
                itemBuilder: (context, index) => cardAt(index),
              );
            }

            return Column(
              children: [
                for (int i = 0; i < modules.length; i++) ...[
                  if (i > 0) 16.hBox,
                  cardAt(i),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}

class ActiveModulesMobileLayoutTab extends GetView<SettingsController> {
  const ActiveModulesMobileLayoutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: 16.hBox),
        SliverPadding(
          padding: context.paddingSymmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final module = AppModules.availableModules[index];
                return Obx(() {
                  final isEnabled =
                      controller.activeModuleTypes.contains(module.type);
                  return Padding(
                    padding: context.paddingOnly(bottom: 12),
                    child: _ActiveModuleCard(
                      module: module,
                      isEnabled: isEnabled,
                      onToggleChanged: (value) =>
                          controller.toggleModule(module, value),
                    ),
                  );
                });
              },
              childCount: AppModules.availableModules.length,
            ),
          ),
        ),
        SliverToBoxAdapter(child: 24.hBox),
      ],
    );
  }
}

class _ActiveModulesSectionHeader extends StatelessWidget {
  const _ActiveModulesSectionHeader({
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

class _ActiveModuleCard extends StatelessWidget {
  const _ActiveModuleCard({
    required this.module,
    required this.isEnabled,
    required this.onToggleChanged,
  });

  final AppModule module;
  final bool isEnabled;
  final ValueChanged<bool> onToggleChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final borderColor = isEnabled ? colors.primary : colors.cardBorderColor;
    final bgColor =
        isEnabled ? colors.settingsSegmentSelectedFill : colors.cardBackgroundColor;
    final iconBgColor = isEnabled
        ? colors.settingsSoftPrimaryChipFill
        : colors.muted;

    return Semantics(
      label: '${module.title} module',
      selected: isEnabled,
      button: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: 16.radius,
          border: Border.all(color: borderColor, width: 1.r),
        ),
        child: Padding(
          padding: context.paddingAll(16),
          child: Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: 12.radius,
                ),
                child: Center(
                  child: module.icon.buildIconWidget(
                    size: 20.r,
                    color: isEnabled ? colors.primary : colors.mutedForeground,
                  ),
                ),
              ),
              8.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      module.title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.cardForeground,
                      height: 1.0,
                    ),
                    4.hBox,
                    CustomText(
                      module.subtitle,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: colors.mutedForeground,
                      height: 1.33,
                    ),
                  ],
                ),
              ),
              12.wBox,
              CompactAppSwitch(
                value: isEnabled,
                onChanged: onToggleChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
