part of '../imports/settings_imports.dart';

class SettingsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SettingsController get to => Get.find();
  SettingsController({
    required SettingsRepositoryImpl settingsRepository,
    // required ProfileRepository userRepository,
  }) : _settingsRepository =
            settingsRepository /* ,
        _userRepository = userRepository */
  ;
  // Dependencies
  final SettingsRepositoryImpl _settingsRepository;
  // final ProfileRepository _userRepository;

  // Animation Controllers
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  // User State
  final Rx<ApiUserInfo?> currentUser = Rx<ApiUserInfo?>(null);
  final Rx<bool> isLoadingUser = Rx(false);

  // Settings State
  final Rx<bool> pushNotificationsEnabled = Rx(false);
  final Rx<bool> emailNotificationsEnabled = Rx(false);
  final Rx<bool> biometricEnabled = Rx(false);
  final Rx<bool> autoBackup = Rx(false);
  final Rx<bool> dataSync = Rx(false);

  // UI State
  // final RxInt currentPage = 0.obs;
  final Rx<bool> isModalOpen = Rx(false);
  final Rx<bool> isDarkMode = Rx(false);
  final Rx<String> searchQuery = Rx("");
  final Rx<List<String>> recentlyChanged = Rx(<String>[]);

  // Theme & Localization
  final Rx<XTheme> currentTheme = Rx(PlayxTheme.currentTheme);
  final Rx<XLocale> selectedLanguage = Rx(PlayxLocalization.currentXLocale);
  final RxList<XLocale> supportedLocales = <XLocale>[].obs;

  // Loading States
  final Rx<bool> isResetting = Rx(false);
  final Rx<bool> isSyncing = Rx(false);
  final Rx<bool> isExporting = Rx(false);

  // Error Handling
  final Rx<String> lastError = Rx("");
  final Rx<bool> hasError = Rx(false);

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _initializeSettings();
    _loadUserData();
    _setupListeners();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    ));

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
  }

  void _initializeSettings() {
    // Load supported locales
    supportedLocales.value = PlayxLocalization.supportedXLocales;
    selectedLanguage.value = PlayxLocalization.currentXLocale;

    // Load current theme
    currentTheme.value = PlayxTheme.currentTheme;
    isDarkMode.value = PlayxTheme.currentTheme.id.contains('dark');

    // Load settings from storage
    _loadSettings();
  }

  void _setupListeners() {
    // Listen to theme changes
    ever(currentTheme, (theme) {
      isDarkMode.value = theme.id.contains('dark');
      _saveSettings();
    });

    // Listen to language changes
    ever(selectedLanguage, (_) => _saveSettings());

    // Listen to notification settings
    ever(pushNotificationsEnabled, (_) {
      _markAsRecentlyChanged('Push Notifications');
      _saveSettings();
    });

    ever(emailNotificationsEnabled, (_) {
      _markAsRecentlyChanged('Email Notifications');
      _saveSettings();
    });

    // Listen to security settings
    ever(biometricEnabled, (_) {
      _markAsRecentlyChanged('Biometric Login');
      _saveSettings();
    });

    // Listen to data settings
    ever(autoBackup, (_) {
      _markAsRecentlyChanged('Auto Backup');
      _saveSettings();
    });

    ever(dataSync, (_) {
      _markAsRecentlyChanged('Data Sync');
      _saveSettings();
    });
  }

  Future<void> _loadUserData() async {
    try {
      isLoadingUser.value = true;

      // final user = await _userRepository.getUserProfile();
      final user = await Future.delayed(
          const Duration(seconds: 2),
          () => ApiUserInfo(
                id: 1,
                firstName: 'John',
                lastName: 'Doe',
                documentId: '',
                username: 'johndoe',
                email: '4tH2W@example.com',
                image: MediaItem(
                    url: "https://randomuser.me/api/portraits/men/1.jpg"),
              ));
      currentUser.value = user;
    } catch (e) {
      _handleError('Failed to load user data: $e');
    } finally {
      isLoadingUser.value = false;
    }
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await _settingsRepository.getSettings();

      pushNotificationsEnabled.value =
          settings.pushNotificationsEnabled ?? false;
      emailNotificationsEnabled.value =
          settings.emailNotificationsEnabled ?? false;
      biometricEnabled.value = settings.biometricEnabled ?? false;
      autoBackup.value = settings.autoBackup ?? false;
      dataSync.value = settings.dataSync ?? false;
    } catch (e) {
      _handleError('Failed to load settings: $e');
    }
  }

  Future<void> _saveSettings() async {
    try {
      final settings = Settings(
        pushNotificationsEnabled: pushNotificationsEnabled.value,
        emailNotificationsEnabled: emailNotificationsEnabled.value,
        biometricEnabled: biometricEnabled.value,
        autoBackup: autoBackup.value,
        dataSync: dataSync.value,
        themeId: currentTheme.value.id,
        languageCode: selectedLanguage.value.languageCode,
      );

      await _settingsRepository.saveSettings(settings);
    } catch (e) {
      _handleError('Failed to save settings: $e');
    }
  }

  void _markAsRecentlyChanged(String settingName) {
    recentlyChanged.value.insert(0, settingName);
    if (recentlyChanged.value.length > 5) {
      recentlyChanged.value.removeLast();
    }

    // Remove from recently changed after 5 seconds
    Timer(const Duration(seconds: 5), () {
      recentlyChanged.value.remove(settingName);
    });
  }

  void _handleError(String error) {
    lastError.value = error;
    hasError.value = true;
    Alert.error(message: error);

    // Clear error after 3 seconds
    Timer(const Duration(seconds: 3), () {
      hasError.value = false;
    });
  }

  // Notification Methods
  Future<void> togglePushNotifications() async {
    try {
      pushNotificationsEnabled.toggle();

      if (pushNotificationsEnabled.value) {
        await _settingsRepository.enablePushNotifications();
        Alert.success(message: 'Push notifications enabled');
      } else {
        await _settingsRepository.disablePushNotifications();
        Alert.success(message: 'Push notifications disabled');
      }
    } catch (e) {
      // Revert the toggle if operation failed
      pushNotificationsEnabled.toggle();
      _handleError('Failed to update push notifications: $e');
    }
  }

  Future<void> toggleEmailNotifications() async {
    try {
      emailNotificationsEnabled.toggle();

      if (emailNotificationsEnabled.value) {
        await _settingsRepository.enableEmailNotifications();
        Alert.success(
          message: 'Email notifications enabled',
        );
      } else {
        await _settingsRepository.disableEmailNotifications();
        Alert.success(message: 'Email notifications disabled');
      }
    } catch (e) {
      // Revert the toggle if operation failed
      emailNotificationsEnabled.toggle();
      _handleError('Failed to update email notifications: $e');
    }
  }

  // Security Methods
  Future<void> toggleBiometric() async {
    try {
      // Check if biometric is available first
      final isAvailable = await _settingsRepository.isBiometricAvailable();
      if (!isAvailable) {
        Get.snackbar(
          'Error',
          'Biometric authentication is not available on this device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          colorText: Colors.red,
        );
        return;
      }

      if (!biometricEnabled.value) {
        // Authenticate before enabling
        final authenticated =
            await _settingsRepository.authenticateWithBiometric();
        if (!authenticated) {
          Get.snackbar(
            'Error',
            'Biometric authentication failed',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withValues(alpha: 0.1),
            colorText: Colors.red,
          );
          return;
        }
      }

      biometricEnabled.toggle();
      await _settingsRepository.setBiometricEnabled(biometricEnabled.value);

      Alert.success(
        message: biometricEnabled.value
            ? 'Biometric authentication enabled'
            : 'Biometric authentication disabled',
      );
    } catch (e) {
      // Revert the toggle if operation failed
      biometricEnabled.toggle();
      _handleError('Failed to update biometric settings: $e');
    }
  }

  Future<void> navigate2FA() async {
    try {
      final is2FAEnabled = await _settingsRepository.is2FAEnabled();
      if (is2FAEnabled) {
        // PlayxNavigation.toNamed(Routes.twoFactorSettings);
      } else {
        // PlayxNavigation.toNamed(Routes.enable2FA);
      }
    } catch (e) {
      _handleError('Failed to navigate to 2FA settings: $e');
    }
  }

  Future<void> showLoginHistory() async {
    try {
      // PlayxNavigation.toNamed(Routes.loginHistory);
    } catch (e) {
      _handleError('Failed to show login history: $e');
    }
  }

  // Data Management Methods
  Future<void> toggleAutoBackup() async {
    try {
      autoBackup.toggle();

      if (autoBackup.value) {
        await _settingsRepository.enableAutoBackup();
        Alert.success(message: 'Auto backup enabled');
      } else {
        await _settingsRepository.disableAutoBackup();
        Alert.success(message: 'Auto backup disabled');
      }
    } catch (e) {
      // Revert the toggle if operation failed
      autoBackup.toggle();
      _handleError('Failed to update auto backup: $e');
    }
  }

  Future<void> toggleDataSync() async {
    try {
      isSyncing.value = true;
      dataSync.toggle();

      if (dataSync.value) {
        await _settingsRepository.enableDataSync();
        Alert.success(message: 'Data sync enabled');
      } else {
        await _settingsRepository.disableDataSync();
        Alert.success(message: 'Data sync disabled');
      }
    } catch (e) {
      // Revert the toggle if operation failed
      dataSync.toggle();
      _handleError('Failed to update data sync: $e');
    } finally {
      isSyncing.value = false;
    }
  }

  Future<void> showStorageUsage() async {
    try {
      final storageInfo = await _settingsRepository.getStorageUsage();

      Get.dialog(
        AlertDialog(
          title: const Text('Storage Usage'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStorageItem(
                  'Photos', storageInfo.photos, storageInfo.total),
              _buildStorageItem(
                  'Videos', storageInfo.videos, storageInfo.total),
              _buildStorageItem(
                  'Documents', storageInfo.documents, storageInfo.total),
              _buildStorageItem('Cache', storageInfo.cache, storageInfo.total),
              const Divider(),
              _buildStorageItem('Total', storageInfo.total, storageInfo.total,
                  isTotal: true),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Close'),
            ),
            if (storageInfo.cache > 0)
              ElevatedButton(
                onPressed: () async {
                  await _settingsRepository.clearCache();
                  PlayxNavigation.pop();
                  Get.snackbar('Success', 'Cache cleared successfully');
                },
                child: const Text('Clear Cache'),
              ),
          ],
        ),
      );
    } catch (e) {
      _handleError('Failed to get storage usage: $e');
    }
  }

  Widget _buildStorageItem(String label, int size, int total,
      {bool isTotal = false}) {
    final percentage = total > 0 ? (size / total * 100) : 0.0;
    final sizeText = _formatBytes(size);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sizeText,
                style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (!isTotal)
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }

  Future<void> exportData() async {
    try {
      isExporting.value = true;
      final exportedData = await _settingsRepository.exportData();

      // In a real app, you'd save this to a file or share it
      Alert.success(message: 'Data exported successfully $exportedData');
    } catch (e) {
      _handleError('Failed to export data: $e');
    } finally {
      isExporting.value = false;
    }
  }

  // Theme and Language Methods
  Future<void> handleThemeSelection(XTheme theme,
      {required BuildContext context}) async {
    try {
      await PlayxTheme.updateTo(theme);
      currentTheme.value = theme;
      closeSettingsModalSheet();
    } catch (e) {
      _handleError('Failed to update theme: $e');
    }
  }

  Future<void> handleLanguageSelection(XLocale locale) async {
    try {
      PlayxLocalization.updateTo(locale);
      selectedLanguage.value = locale;
      closeSettingsModalSheet();
    } catch (e) {
      _handleError('Failed to update language: $e');
    }
  }

  // Support Methods
  Future<void> openHelpCenter() async {
    try {
      // PlayxNavigation.toNamed(Routes.helpCenter);
    } catch (e) {
      _handleError('Failed to open help center: $e');
    }
  }

  Future<void> contactSupport() async {
    try {
      // PlayxNavigation.toNamed(Routes.contactSupport);
    } catch (e) {
      _handleError('Failed to open contact support: $e');
    }
  }

  // Reset and Logout Methods
  Future<void> resetSettings() async {
    try {
      isResetting.value = true;
      await _settingsRepository.resetSettings();

      // Reset local state
      pushNotificationsEnabled.value = false;
      emailNotificationsEnabled.value = false;
      biometricEnabled.value = false;
      autoBackup.value = false;
      dataSync.value = false;

      Alert.success(message: 'Settings reset to default values');
    } catch (e) {
      _handleError('Failed to reset settings: $e');
    } finally {
      isResetting.value = false;
    }
  }

  Future<void> handleLogOutTap(BuildContext context) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.logout,
              color: Colors.red,
              size: 24.r,
            ),
            SizedBox(width: 12.w),
            const CustomText('Logout'),
          ],
        ),
        content: const CustomText(
          'Are you sure you want to logout?',
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const CustomText(AppTrans.cancel),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const CustomText(AppTrans.logout),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        await Get.find<ApiHelper>().logout();
      } catch (e) {
        _handleError('Failed to logout: $e');
      }
    }
  }

  Future<void> shareProfile() async {
    try {
      final user = currentUser.value;
      if (user != null) {
        // final shareText =
        //     "Check out ${user.firstName} ${user.lastName}'s profile!";
        // Share.share(shareText);
        Alert.success(message: 'Profile shared successfully');
      }
    } catch (e) {
      _handleError('Failed to share profile: $e');
    }
  }

  // Modal Sheet Methods
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

  // Sync Methods
  Future<void> syncSettingsToServer() async {
    try {
      isSyncing.value = true;
      await _settingsRepository.syncSettingsToServer();

      Alert.success(message: 'Settings synced to server');
    } catch (e) {
      _handleError('Failed to sync settings: $e');
    } finally {
      isSyncing.value = false;
    }
  }

  final currentPage = ValueNotifier(SettingsPage.settings.index);

  Future<void> showSettingsModalSheet(
    BuildContext context,
  ) {
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
      BuildSettingsPrivacyWidget._buildPrivacyPolicyModalPage(context),
      BuildSettingsTermsWidget._buildTermsModalPage(context),
    ];

    return CustomModal.showModal(
      context: context,
      pageListBuilder: (context) => settingsPages,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
      pageIndexNotifier: currentPage,
    );
  }

  // Future<void> showSettingsModalPageSheet(
  //   BuildContext context,
  //   SliverWoltModalSheetPage page,
  // ) {
  //   return CustomModal.showPageModal(
  //     context: context,
  //     pageBuilder: (context) => page,
  //     onModalDismissedWithBarrierTap: closeSettingsModalSheet,
  //   );
  // }

  // void closeSettingsModalSheet() {
  //   PlayxNavigation.pop();
  //   currentPage.value = SettingsPage.settings.index;
  // }
}

enum SettingsPage { settings, language, theme, privacy, terms }
