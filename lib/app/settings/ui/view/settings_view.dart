part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Settings Screen',
      child: PlayxThemeSwitchingArea(
        child: Scaffold(
          backgroundColor: context.colors.surface,
          body: SafeArea(
            child: ResponsiveLayoutBuilder(
              mobileBuilder: _buildMobileLayout,
              tabletBuilder: _buildTabletLayout,
              desktopBuilder: _buildDesktopLayout,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverAppBar(
          expandedHeight: 60.h,
          floating: true,
          pinned: true,
          backgroundColor: context.colors.surface,
          elevation: 0,
          title: Semantics(
            header: true,
            child: CustomText(
              'Settings',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ).animate().fadeIn(duration: 600.ms),
          ),
          leading: AppBarLeadingType.drawer.buildWidget(context),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const AnimatedProfileHeader(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.r),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildSection(
                context,
                SettingsSection.values[index],
                index,
              ),
              childCount: SettingsSection.values.length,
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 80.h)),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.surfaceContainer,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: OptimizedScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.r),
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 28.r),
                        SizedBox(width: 12.w),
                        CustomText(
                          'Settings',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: const AnimatedProfileHeader(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: _buildQuickActionsGrid(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 80.h,
                title: Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: CustomText(
                    'Preferences',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildSection(
                      context,
                      SettingsSection.values[index],
                      index,
                    ),
                    childCount: SettingsSection.values.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 280.w,
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            boxShadow: [
              BoxShadow(
                color: context.colors.shadow.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24.r),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: 24.r,
                        color: context.colors.primary,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CustomText(
                      'Settings',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ).animate().fadeIn().slideX(begin: -0.3, end: 0),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: SettingsSection.values.length,
                    itemBuilder: (context, index) {
                      final section = SettingsSection.values[index];
                      final isSelected =
                          controller.selectedSectionIndex.value == index;

                      return Semantics(
                        button: true,
                        selected: isSelected,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ListTile(
                            leading: Icon(
                              _getSectionIcon(section),
                              color: isSelected
                                  ? context.colors.primary
                                  : context.colors.onSurface
                                      .withValues(alpha: 0.7),
                            ),
                            title: CustomText(
                              _getSectionTitle(section),
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? context.colors.primary
                                  : context.colors.onSurface,
                            ),
                            onTap: () {
                              HapticFeedback.selectionClick();
                              controller.selectedSectionIndex.value = index;
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        )
                            .animate(delay: (index * 50).ms)
                            .fadeIn()
                            .slideX(begin: -0.2, end: 0),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24.r),
                child: const AnimatedProfileHeader(),
              ),
              Expanded(
                child: Obx(() {
                  final selectedSection = SettingsSection
                      .values[controller.selectedSectionIndex.value];

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: _buildSection(
                      context,
                      selectedSection,
                      controller.selectedSectionIndex.value,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, SettingsSection section, int index) {
    return AnimatedSettingsCard(
      title: _getSectionTitle(section),
      icon: _getSectionIcon(section),
      delay: index * 100,
      child: Column(
        children: _getSectionTiles(context, section),
      ),
    );
  }

  List<Widget> _getSectionTiles(BuildContext context, SettingsSection section) {
    switch (section) {
      case SettingsSection.preferences:
        return [
          Obx(
            () => InteractiveSettingsTile(
              title: 'Language',
              subtitle: controller.selectedLanguage.value.name,
              icon: Icons.language,
              onTap: () => _showLanguageDialog(context),
              semanticLabel: 'Change language',
            ),
          ),
          Obx(
            () => InteractiveSettingsTile(
              title: 'Theme',
              subtitle: controller.currentTheme.value.name,
              icon: Icons.dark_mode,
              onTap: () => _showThemeDialog(context),
              semanticLabel: 'Change theme',
            ),
          ),
        ];

      case SettingsSection.notifications:
        return [
          Obx(
            () => InteractiveSettingsTile(
              title: 'Push Notifications',
              subtitle: 'Receive push notifications',
              icon: Icons.notifications_active,
              showToggle: true,
              toggleValue: controller.pushNotificationsEnabled.value,
              onToggleChanged: (_) => controller.togglePushNotifications(),
              semanticLabel: 'Toggle push notifications',
            ),
          ),
          Obx(
            () => InteractiveSettingsTile(
              title: 'Email Notifications',
              subtitle: 'Receive email updates',
              icon: Icons.email,
              showToggle: true,
              toggleValue: controller.emailNotificationsEnabled.value,
              onToggleChanged: (_) => controller.toggleEmailNotifications(),
              semanticLabel: 'Toggle email notifications',
            ),
          ),
        ];

      case SettingsSection.security:
        return [
          Obx(
            () => InteractiveSettingsTile(
              title: 'Biometric Login',
              subtitle: 'Use fingerprint or face ID',
              icon: Icons.fingerprint,
              showToggle: true,
              toggleValue: controller.biometricEnabled.value,
              onToggleChanged: (_) => controller.toggleBiometric(),
              semanticLabel: 'Toggle biometric login',
            ),
          ),
          const InteractiveSettingsTile(
            title: 'Two-Factor Authentication',
            subtitle: 'Add an extra layer of security',
            icon: Icons.security,
            trailingIcon: Icons.arrow_forward_ios,
            semanticLabel: 'Configure two-factor authentication',
          ),
          const InteractiveSettingsTile(
            title: 'Login History',
            subtitle: 'View recent login activity',
            icon: Icons.history,
            trailingIcon: Icons.arrow_forward_ios,
            semanticLabel: 'View login history',
          ),
        ];

      case SettingsSection.dataStorage:
        return [
          Obx(
            () => InteractiveSettingsTile(
              title: 'Auto Backup',
              subtitle: 'Automatically backup your data',
              icon: Icons.backup,
              showToggle: true,
              toggleValue: controller.autoBackupEnabled.value,
              onToggleChanged: (_) => controller.toggleAutoBackup(),
              semanticLabel: 'Toggle auto backup',
            ),
          ),
          Obx(
            () => InteractiveSettingsTile(
              title: 'Data Sync',
              subtitle: 'Sync data across devices',
              icon: Icons.sync,
              showToggle: true,
              toggleValue: controller.dataSyncEnabled.value,
              onToggleChanged: (_) => controller.toggleDataSync(),
              semanticLabel: 'Toggle data sync',
            ),
          ),
          const InteractiveSettingsTile(
            title: 'Storage Usage',
            subtitle: 'View storage details',
            icon: Icons.storage,
            trailingIcon: Icons.arrow_forward_ios,
            semanticLabel: 'View storage usage',
          ),
        ];

      case SettingsSection.support:
        return [
          InteractiveSettingsTile(
            title: 'Privacy Policy',
            subtitle: 'View our privacy policy',
            icon: Icons.privacy_tip,
            onTap: () => PlayxNavigation.toNamed(Routes.privacyPolicy),
            trailingIcon: Icons.arrow_forward_ios,
            semanticLabel: 'View privacy policy',
          ),
          InteractiveSettingsTile(
            title: 'Terms & Conditions',
            subtitle: 'View terms of service',
            icon: Icons.description,
            onTap: () => PlayxNavigation.toNamed(Routes.termsConditions),
            trailingIcon: Icons.arrow_forward_ios,
            semanticLabel: 'View terms and conditions',
          ),
          const InteractiveSettingsTile(
            title: 'Help Center',
            subtitle: 'Get help and support',
            icon: Icons.help,
            trailingIcon: Icons.arrow_forward_ios,
            semanticLabel: 'Open help center',
          ),
        ];

      case SettingsSection.account:
        return [
          InteractiveSettingsTile(
            title: 'Reset Settings',
            subtitle: 'Reset all settings to default',
            icon: Icons.restore,
            onTap: () => controller.resetSettings(context),
            isDangerous: true,
            semanticLabel: 'Reset all settings',
          ),
          InteractiveSettingsTile(
            title: 'Logout',
            subtitle: 'Sign out of your account',
            icon: Icons.logout,
            onTap: () => controller.logout(context),
            isDangerous: true,
            semanticLabel: 'Logout from account',
          ),
        ];
    }
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    final actions = <QuickActions>[
      QuickActions(
        title: 'Backup',
        icon: Icons.backup,
        color: Colors.blue,
        tap: () {},
      ),
      QuickActions(
        title: 'Security',
        icon: Icons.security,
        color: Colors.green,
        tap: () {},
      ),
      QuickActions(
        title: 'Privacy',
        icon: Icons.privacy_tip,
        color: Colors.orange,
        tap: () => PlayxNavigation.toNamed(Routes.privacyPolicy),
      ),
      QuickActions(
        title: 'Help',
        icon: Icons.help,
        color: Colors.purple,
        tap: () {},
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.3,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Semantics(
          button: true,
          label: action.title,
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              action.tap();
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    action.color.withValues(alpha: 0.1),
                    action.color.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: action.color.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(action.icon, size: 28.r, color: action.color),
                  SizedBox(height: 8.h),
                  CustomText(
                    action.title,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          )
              .animate(delay: (index * 100).ms)
              .scale(
                begin: const Offset(0.8, 0.8),
              )
              .fadeIn(),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hapticFeedback = HapticFeedbackManager();
    final screenWidth = context.mediaQuery.size.width;
    final dialogPadding = screenWidth < 600 ? 16.r : 24.r;

    showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: colorScheme.surface,
        child: Container(
          padding: EdgeInsets.all(dialogPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                'Select Language',
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              ...controller.supportedLocales.map((locale) {
                final isSelected = controller.selectedLanguage.value == locale;
                return ListTile(
                  title: CustomText(
                    locale.name,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                    fontSize: 16.sp,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: colorScheme.primary,
                          size: 24.r,
                          shadows: isDark
                              ? [
                                  Shadow(
                                      color: colorScheme.primary
                                          .withValues(alpha: 0.3),
                                      blurRadius: 2)
                                ]
                              : null,
                        )
                      : null,
                  onTap: () {
                    hapticFeedback.lightImpact();
                    controller.changeLanguage(locale);
                    Navigator.of(context).pop(true);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  tileColor: isSelected
                      ? colorScheme.primary.withValues(alpha: 0.08)
                      : null,
                ).animate().fadeIn().slideX(begin: -0.1, end: 0);
              }),
            ],
          ),
        ),
      ).animate().scale(begin: const Offset(0.9, 0.9), duration: 200.ms),
    );
  }

  void _showThemeDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hapticFeedback = HapticFeedbackManager();
    final screenWidth = context.mediaQuery.size.width;
    final dialogPadding = screenWidth < 600 ? 16.r : 24.r;

    showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: colorScheme.surface,
        child: Container(
          padding: EdgeInsets.all(dialogPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                'Select Theme',
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              ...PlayxTheme.supportedThemes.map((theme) {
                final isSelected = controller.currentTheme.value == theme;
                return ListTile(
                  title: CustomText(
                    theme.name,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                    fontSize: 16.sp,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: colorScheme.primary,
                          size: 24.r,
                          shadows: isDark
                              ? [
                                  Shadow(
                                      color: colorScheme.primary
                                          .withValues(alpha: 0.3),
                                      blurRadius: 2)
                                ]
                              : null,
                        )
                      : null,
                  onTap: () {
                    hapticFeedback.lightImpact();
                    controller.changeTheme(theme, context: context);
                    Navigator.of(context).pop(true);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  tileColor: isSelected
                      ? colorScheme.primary.withValues(alpha: 0.08)
                      : null,
                ).animate().fadeIn().slideX(begin: -0.1, end: 0);
              }),
            ],
          ),
        ),
      ).animate().scale(begin: const Offset(0.9, 0.9), duration: 200.ms),
    );
  }

  String _getSectionTitle(SettingsSection section) {
    switch (section) {
      case SettingsSection.preferences:
        return 'Preferences';
      case SettingsSection.notifications:
        return 'Notifications';
      case SettingsSection.security:
        return 'Security & Privacy';
      case SettingsSection.dataStorage:
        return 'Data & Storage';
      case SettingsSection.support:
        return 'Support & Legal';
      case SettingsSection.account:
        return 'Account';
    }
  }

  IconData _getSectionIcon(SettingsSection section) {
    switch (section) {
      case SettingsSection.preferences:
        return Icons.tune;
      case SettingsSection.notifications:
        return Icons.notifications;
      case SettingsSection.security:
        return Icons.security;
      case SettingsSection.dataStorage:
        return Icons.cloud;
      case SettingsSection.support:
        return Icons.info;
      case SettingsSection.account:
        return Icons.account_circle;
    }
  }

  static SliverWoltModalSheetPage buildSettingsModalSheetPage(
    SettingsController controller,
    BuildContext context,
  ) {
    return CustomModal.buildCustomModalPage(
      title: AppTrans.settings,
      body: const SettingsView(),
      onClosePressed: controller.closeSettingsModalSheet,
      context: context,
    );
  }
}
