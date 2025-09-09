part of '../imports/settings_imports.dart';

class SettingsController extends GetxController
    with GetTickerProviderStateMixin {
  SettingsController({
    required SettingsRepository settingsRepository,
    required ProfileRepository profileRepository,
  })  : _repository = settingsRepository,
        _profileRepository = profileRepository;
  final SettingsRepository _repository;
  final ProfileRepository _profileRepository;

  final Rx<DataState<UserProfile>> currentUser =
      Rx<DataState<UserProfile>>(const DataState.loading());

  final RxBool pushNotificationsEnabled = RxBool(false);
  final RxBool emailNotificationsEnabled = RxBool(true);
  final RxBool biometricEnabled = RxBool(false);
  final RxBool autoBackupEnabled = RxBool(true);
  final RxBool dataSyncEnabled = RxBool(true);

  final Rx<XTheme> currentTheme = Rx(PlayxTheme.currentTheme);
  final Rx<XLocale> selectedLanguage = Rx(PlayxLocalization.currentXLocale);
  final RxList<XLocale> supportedLocales =
      RxList(PlayxLocalization.supportedXLocales);

  final RxInt selectedSectionIndex = RxInt(0);
  final Rx<bool> isModalOpen = Rx(false);

  late AnimationController profileAnimationController;
  late AnimationController sectionAnimationController;
  late Animation<double> profileScaleAnimation;
  late Animation<double> sectionSlideAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _loadUserProfile();
    _loadSettings();
  }

  void _initializeAnimations() {
    profileAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    sectionAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    profileScaleAnimation = CurvedAnimation(
      parent: profileAnimationController,
      curve: Curves.elasticOut,
    );

    sectionSlideAnimation = CurvedAnimation(
      parent: sectionAnimationController,
      curve: Curves.easeOutCubic,
    );

    profileAnimationController.forward();
    sectionAnimationController.forward();
  }

  Future<void> _loadUserProfile() async {
    try {
      currentUser.value = const DataState<UserProfile>.loading();
      final profile = await _profileRepository.getUserProfile();
      final demo = UserProfile(
        id: 1,
        firstName: 'Omar',
        lastName: 'Saeed',
        documentId: '',
        username: 'omarsaeed35',
        email: '4tH2W@example.com',
        image: MediaItem(url: "https://randomuser.me/api/portraits/men/1.jpg"),
      );
      profile.when(
        success: (data) {
          currentUser.value = DataState<UserProfile>.success(data.toUserInfo());
        },
        error: (error) {
          currentUser.value = DataState<UserProfile>.success(demo);
        },
      );

      await Future.delayed(const Duration(milliseconds: 300));
      profileAnimationController.forward();
    } catch (e) {
      final error = 'Failed to load profile $e';
      _showError(error);
      currentUser.value = DataState<UserProfile>.fromDefaultError(error: error);
    }
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await _repository.getSettings();
      settings.when(
        success: (success) {
          pushNotificationsEnabled.value =
              success.notificationSettings?.pushEnabled ?? false;
          emailNotificationsEnabled.value =
              success.notificationSettings?.emailEnabled ?? true;
          biometricEnabled.value =
              success.securitySettings?.biometricEnabled ?? false;
          autoBackupEnabled.value =
              success.dataSettings?.autoBackupEnabled ?? true;
          dataSyncEnabled.value = success.dataSettings?.dataSyncEnabled ?? true;
        },
        error: (error) => _showError('Failed to load settings'),
      );
    } catch (e) {
      _showError('Failed to load settings');
    }
  }

  Future<void> togglePushNotifications() async {
    HapticFeedback.lightImpact();
    pushNotificationsEnabled.toggle();
    switch (pushNotificationsEnabled.value) {
      case true:
        await _repository.enablePushNotifications();
      case false:
        await _repository.disablePushNotifications();
    }

    _showSuccess(
      'Push notifications ${pushNotificationsEnabled.value ? "enabled" : "disabled"}',
    );
  }

  Future<void> toggleEmailNotifications() async {
    HapticFeedback.lightImpact();
    emailNotificationsEnabled.toggle();
    switch (emailNotificationsEnabled.value) {
      case true:
        await _repository.enableEmailNotifications();
      case false:
        await _repository.disableEmailNotifications();
    }
  }

  Future<void> toggleBiometric() async {
    HapticFeedback.mediumImpact();
    final canCheckBiometrics = await LocalAuthentication().canCheckBiometrics;
    if (!canCheckBiometrics && !biometricEnabled.value) {
      _showError('Biometric authentication not available');
      return;
    }

    biometricEnabled.toggle();
    await _repository.setBiometricEnabled(biometricEnabled.value);
  }

  Future<void> toggleAutoBackup() async {
    HapticFeedback.lightImpact();
    autoBackupEnabled.toggle();
    switch (autoBackupEnabled.value) {
      case true:
        await _repository.enableAutoBackup();
      case false:
        await _repository.disableAutoBackup();
    }
  }

  Future<void> toggleDataSync() async {
    HapticFeedback.lightImpact();
    dataSyncEnabled.toggle();
    switch (dataSyncEnabled.value) {
      case true:
        await _repository.enableDataSync();
      case false:
        await _repository.disableDataSync();
    }
  }

  void changeTheme(XTheme theme, {required BuildContext context}) {
    HapticFeedback.selectionClick();
    currentTheme.value = theme;
    PlayxTheme.updateTo(theme);

    sectionAnimationController.reset();
    sectionAnimationController.forward();
  }

  void changeLanguage(XLocale locale) {
    HapticFeedback.selectionClick();
    selectedLanguage.value = locale;
    PlayxLocalization.updateTo(locale);
  }

  Future<void> editProfile() async {
    HapticFeedback.mediumImpact();
    await PlayxNavigation.toNamed(Routes.updateProfile);
    _loadUserProfile();
  }

  Future<void> shareProfile() async {
    HapticFeedback.mediumImpact();
    final profile = currentUser.value.data;
    if (profile == null) return;
    await Share.share(
      'Check out my profile: ${profile.displayName}\n'
      'Member since: ${profile.memberSince}',
    );
    Alert.success(message: 'Profile shared successfully');
  }

  Future<void> logout(BuildContext context) async {
    HapticFeedback.heavyImpact();
    showDialog<bool>(
      context: context,
      builder: (context) => _buildLogoutDialog(context),
    ).then((confirmed) async {
      if (confirmed == true) await Get.find<ApiHelper>().logout();
    });
  }

  Future<void> resetSettings(BuildContext context) async {
    HapticFeedback.heavyImpact();
    showDialog<bool>(
      context: context,
      builder: (context) => _buildResetDialog(context),
    ).then((confirmed) async {
      if (confirmed == true) {
        await _repository.resetSettings();
        _loadSettings();
        _showSuccess('Settings reset successfully');
      }
    });
  }

  Widget _buildLogoutDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hapticFeedback = HapticFeedbackManager();
    final screenWidth = context.mediaQuery.size.width;
    final dialogPadding = screenWidth < 600 ? 16.r : 24.r;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: colorScheme.surface,
      contentPadding: EdgeInsets.all(dialogPadding),
      title: Row(
        children: [
          Icon(Icons.logout, color: colorScheme.error, size: 24.r),
          SizedBox(width: 12.w),
          CustomText(
            'Logout',
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
      content: CustomText(
        'Are you sure you want to logout?',
        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 16.sp,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            hapticFeedback.lightImpact();
            PlayxNavigation.pop(false);
          },
          child: CustomText(
            'Cancel',
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            hapticFeedback.lightImpact();
            PlayxNavigation.pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
          ),
          child: CustomText(
            'Logout',
            color: colorScheme.onError,
            fontSize: 14.sp,
          ),
        ),
      ],
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 200.ms,
        );
  }

  Widget _buildResetDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hapticFeedback = HapticFeedbackManager();
    final screenWidth = context.mediaQuery.size.width;
    final dialogPadding = screenWidth < 600 ? 16.r : 24.r;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: colorScheme.surface,
      contentPadding: EdgeInsets.all(dialogPadding),
      title: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: colorScheme.error,
            size: 24.r,
          ),
          SizedBox(width: 12.w),
          CustomText(
            'Reset Settings',
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            'This will reset all settings to default values. This action cannot be undone.',
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                  fontSize: 16.sp,
                ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: colorScheme.error.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: colorScheme.error,
                  size: 16.r,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomText(
                    'All your preferences will be lost',
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            hapticFeedback.lightImpact();
            PlayxNavigation.pop(false);
          },
          child: CustomText(
            'Cancel',
            color: colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 14.sp,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            hapticFeedback.lightImpact();
            PlayxNavigation.pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
          ),
          child: CustomText(
            'Reset',
            color: colorScheme.onError,
            fontSize: 14.sp,
          ),
        ),
      ],
    ).animate().scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 200.ms,
        );
  }

  void _showSuccess(String message) {
    Alert.success(message: message, duration: const Duration(seconds: 2));
  }

  void _showError(String message) {
    Alert.error(message: message);
  }

  @override
  void onClose() {
    profileAnimationController.dispose();
    sectionAnimationController.dispose();
    super.onClose();
  }

  void showSettingsModalPageSheet(
    BuildContext context,
    SliverWoltModalSheetPage page,
  ) {
    isModalOpen.value = true;
    WoltModalSheet.show<void>(
      context: context,
      pageListBuilder: (context) => [page],
      onModalDismissedWithDrag: closeSettingsModalSheet,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
    );
    /* 
        return CustomModal.showPageModal(
      context: context,
      pageBuilder: (context) => page,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
    );
     */
  }

  void closeSettingsModalSheet() {
    isModalOpen.value = false;
    PlayxNavigation.pop();

    currentPage.value = SettingsPage.settings.index;
  }

  final currentPage = ValueNotifier(SettingsPage.settings.index);

  Future<void> showSettingsModalSheet(BuildContext context) {
    final List<SliverWoltModalSheetPage> settingsPages = [
      SettingsView.buildSettingsModalSheetPage(this, context),
      BuildSettingsLanguageWidget.buildModalPage(
        controller: this,
        context: context,
        isOnlyPage: false,
      ),
      BuildSettingsThemeWidget.buildModalPage(
        controller: this,
        context: context,
        isOnlyPage: false,
      ),
    ];

    return CustomModal.showModal(
      context: context,
      pageListBuilder: (context) => settingsPages,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
      pageIndexNotifier: currentPage,
    );
  }
}

enum SettingsPage { settings, language, theme }
