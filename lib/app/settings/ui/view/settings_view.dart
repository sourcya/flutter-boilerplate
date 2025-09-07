part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayxThemeSwitchingArea(
      child: CustomScaffold(
        title: AppTrans.settings,
        leading: AppBarLeadingType.drawerOrRail,
        backgroundColor: context.colors.surface,
        child: _buildResponsiveLayout(context),
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final isDesktop = constraints.maxWidth > 1000;

        if (isDesktop) {
          return _buildDesktopLayout(context);
        } else if (isTablet) {
          return _buildTabletLayout(context);
        } else {
          return _buildMobileLayout(context);
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Hero Profile Header
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 8.0.r),
              const BuildUserProfileHeader()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slideY(begin: -0.3, end: 0),
            ],
          ),
        ),

        // Animated Settings Sections
        _buildAnimatedSectionsList(context),

        // Bottom Padding
        SliverToBoxAdapter(
          child: SizedBox(height: 100.h),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Panel - Profile
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                const BuildUserProfileHeader(),
                SizedBox(height: 20.h),
                _buildQuickActionsGrid(context),
              ],
            ),
          ),
        ),

        // Divider
        Container(
          width: 1,
          color: context.colors.outline.withValues(alpha: 0.2),
        ),

        // Right Panel - Settings
        Expanded(
          flex: 3,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16.r),
                sliver: _buildAnimatedSectionsList(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sidebar
        Container(
          width: 300.w,
          decoration: BoxDecoration(
            color: context.colors.surfaceContainer,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                const BuildUserProfileHeader(),
                SizedBox(height: 24.h),
                _buildNavigationMenu(context),
              ],
            ),
          ),
        ),

        // Main Content
        Expanded(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(24.r),
                sliver: _buildAnimatedSectionsList(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedSectionsList(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        _buildSectionWithAnimation(
          context: context,
          section: _buildPreferencesSection(),
          delay: 100,
        ),
        _buildSectionWithAnimation(
          context: context,
          section: _buildNotificationsSection(),
          delay: 200,
        ),
        _buildSectionWithAnimation(
          context: context,
          section: _buildSecuritySection(),
          delay: 300,
        ),
        _buildSectionWithAnimation(
          context: context,
          section: _buildDataSection(),
          delay: 400,
        ),
        _buildSectionWithAnimation(
          context: context,
          section: _buildLegalSection(),
          delay: 500,
        ),
        _buildSectionWithAnimation(
          context: context,
          section: _buildActionsSection(),
          delay: 600,
        ),
      ]),
    );
  }

  Widget _buildSectionWithAnimation({
    required BuildContext context,
    required Widget section,
    required int delay,
  }) {
    return section
        .animate()
        .fadeIn(duration: 600.ms, delay: delay.ms)
        .slideX(begin: -0.1, end: 0, duration: 600.ms, delay: delay.ms)
        .then()
        .shimmer(
          duration: 1500.ms,
          color: context.colors.primary.withValues(alpha: 0.1),
        );
  }

  Widget _buildPreferencesSection() {
    return _buildModernSection(
      title: AppTrans.preferences,
      icon: Icons.tune_outlined,
      children: [
        const BuildSettingsLanguageWidget(),
        const BuildSettingsThemeWidget(),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return _buildModernSection(
      title: AppTrans.notifications,
      icon: Icons.notifications_outlined,
      children: [
        Obx(() => BuildSettingsTile(
              title: AppTrans.pushNotifications,
              subtitle: AppTrans.pushNotificationsDescription,
              icon: Icons.notifications_active_outlined,
              isSelected: controller.pushNotificationsEnabled.value,
              onSelectionChanged: (_) => controller.togglePushNotifications(),
              onTap: controller.togglePushNotifications,
              showToggle: true,
              badgeText:
                  controller.pushNotificationsEnabled.value ? 'ON' : 'OFF',
            )),
        Obx(() => BuildSettingsTile(
              title: AppTrans.emailNotifications,
              subtitle: AppTrans.emailNotificationsDescription,
              icon: Icons.email_outlined,
              isSelected: controller.emailNotificationsEnabled.value,
              onSelectionChanged: (_) => controller.toggleEmailNotifications(),
              onTap: controller.toggleEmailNotifications,
              showToggle: true,
              badgeText:
                  controller.emailNotificationsEnabled.value ? 'ON' : 'OFF',
            )),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return _buildModernSection(
      title: AppTrans.securityPrivacy,
      icon: Icons.security_outlined,
      children: [
        Obx(() => BuildSettingsTile(
              title: AppTrans.biometricLogin,
              subtitle: AppTrans.biometricLoginDescription,
              icon: Icons.fingerprint_outlined,
              isSelected: controller.biometricEnabled.value,
              onSelectionChanged: (_) => controller.toggleBiometric(),
              onTap: controller.toggleBiometric,
              showToggle: true,
              badgeText:
                  controller.biometricEnabled.value ? 'ENABLED' : 'DISABLED',
            )),
        BuildSettingsTile(
          title: AppTrans.twoFactorAuth,
          subtitle: AppTrans.twoFactorAuthDescription,
          icon: Icons.security_outlined,
          onTap: () => controller.navigate2FA(),
          trailingIcon: Icons.arrow_forward_ios,
        ),
        BuildSettingsTile(
          title: AppTrans.loginHistory,
          subtitle: AppTrans.loginHistoryDescription,
          icon: Icons.history_outlined,
          onTap: () => controller.showLoginHistory(),
          trailingIcon: Icons.arrow_forward_ios,
        ),
      ],
    );
  }

  Widget _buildDataSection() {
    return _buildModernSection(
      title: AppTrans.dataStorage,
      icon: Icons.cloud_outlined,
      children: [
        Obx(() => BuildSettingsTile(
              title: AppTrans.autoBackup,
              subtitle: AppTrans.autoBackupDescription,
              icon: Icons.backup_outlined,
              isSelected: controller.autoBackup.value,
              onSelectionChanged: (_) => controller.toggleAutoBackup(),
              onTap: controller.toggleAutoBackup,
              showToggle: true,
              badgeText: controller.autoBackup.value ? 'ON' : 'OFF',
            )),
        Obx(() => BuildSettingsTile(
              title: AppTrans.dataSync,
              subtitle: AppTrans.dataSyncDescription,
              icon: Icons.sync_outlined,
              isSelected: controller.dataSync.value,
              onSelectionChanged: (_) => controller.toggleDataSync(),
              onTap: controller.toggleDataSync,
              showToggle: true,
              badgeText: controller.dataSync.value ? 'SYNCING' : 'OFF',
            )),
        BuildSettingsTile(
          title: AppTrans.storageUsage,
          subtitle: AppTrans.storageUsageDescription,
          icon: Icons.storage_outlined,
          onTap: () => controller.showStorageUsage(),
          trailingIcon: Icons.arrow_forward_ios,
        ),
        BuildSettingsTile(
          title: AppTrans.exportData,
          subtitle: AppTrans.exportDataDescription,
          icon: Icons.download_outlined,
          onTap: () => controller.exportData(),
          trailingIcon: Icons.arrow_forward_ios,
        ),
      ],
    );
  }

  Widget _buildLegalSection() {
    return _buildModernSection(
      title: AppTrans.legalSupport,
      icon: Icons.info_outline,
      children: [
        const BuildSettingsPrivacyWidget(),
        const BuildSettingsTermsWidget(),
        BuildSettingsTile(
          title: AppTrans.helpCenter,
          subtitle: AppTrans.helpCenterDescription,
          icon: Icons.help_outline,
          onTap: () => controller.openHelpCenter(),
          trailingIcon: Icons.arrow_forward_ios,
        ),
        BuildSettingsTile(
          title: AppTrans.contactUs,
          subtitle: AppTrans.contactUsDescription,
          icon: Icons.contact_support_outlined,
          onTap: () => controller.contactSupport(),
          trailingIcon: Icons.arrow_forward_ios,
        ),
      ],
    );
  }

  Widget _buildActionsSection() {
    return _buildModernSection(
      title: AppTrans.actions,
      icon: Icons.settings_outlined,
      children: [
        BuildSettingsTile(
          title: AppTrans.resetSettings,
          subtitle: AppTrans.resetSettingsDescription,
          icon: Icons.restore_outlined,
          onTap: () => _showResetConfirmation(),
          isDangerous: true,
        ),
        const BuildSettingsLogOutWidget(),
      ],
    );
  }

  Widget _buildModernSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: context.colors.shadow.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title, icon, context),
            ...children.map((child) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: child,
                )),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, IconData icon, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 20.r,
              color: context.colors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          CustomText(
            title,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: context.colors.onSurface,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    final actions = [
      {
        'title': AppTrans.backup,
        'icon': Icons.backup_outlined,
        'color': Colors.blue
      },
      {
        'title': AppTrans.security,
        'icon': Icons.security_outlined,
        'color': Colors.green
      },
      {
        'title': AppTrans.privacy,
        'icon': Icons.privacy_tip_outlined,
        'color': Colors.orange
      },
      {
        'title': AppTrans.helpCenter,
        'icon': Icons.help_outline,
        'color': Colors.purple
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.2,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return Container(
          decoration: BoxDecoration(
            color: (action['color']! as Color).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: (action['color']! as Color).withValues(alpha: 0.2),
            ),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action['icon']! as IconData,
                  size: 28.r,
                  color: action['color']! as Color,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  action['title']! as String,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: context.colors.onSurface,
                ),
              ],
            ),
          ),
        ).animate().scale(
              begin: const Offset(0.8, 0.8),
              duration: 400.ms,
              delay: (index * 100).ms,
            );
      },
    );
  }

  Widget _buildNavigationMenu(BuildContext context) {
    final menuItems = [
      {'title': AppTrans.general, 'icon': Icons.settings_outlined},
      {'title': AppTrans.notifications, 'icon': Icons.notifications_outlined},
      {'title': AppTrans.security, 'icon': Icons.security_outlined},
      {'title': AppTrans.privacy, 'icon': Icons.privacy_tip_outlined},
      {'title': AppTrans.helpCenter, 'icon': Icons.help_outline},
    ];

    return Column(
      children: menuItems.map((item) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          child: ListTile(
            leading: Icon(
              item['icon']! as IconData,
              color: context.colors.primary,
            ),
            title: CustomText(
              item['title']! as String,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }

  void _showResetConfirmation() {
    if (Get.context != null) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_outlined,
                color: Colors.orange,
                size: 24.r,
              ),
              SizedBox(width: 12.w),
              const CustomText(AppTrans.resetSettings),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(AppTrans.resetConfirmMessage, maxLines: 3),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 16.r,
                    ),
                    SizedBox(width: 8.w),
                    const Expanded(
                      child: CustomText(
                        AppTrans.resetConfirmWarning,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const CustomText(AppTrans.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                PlayxNavigation.pop();
                controller.resetSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const CustomText(AppTrans.reset),
            ),
          ],
        ).animate().scale(
              begin: const Offset(0.8, 0.8),
              duration: 200.ms,
              curve: Curves.easeOut,
            ),
      );
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
