part of '../imports/settings_imports.dart';

enum SettingsPage { settings, language, theme }

class SettingsController extends GetxController with GetSingleTickerProviderStateMixin {
  SettingsController({SettingsTabs? initialTab}) {
    if (initialTab != null) {
      selectedSettingsTab.value = initialTab;
    }
  }

  Rxn<XLocale> currentLocale = Rxn(PlayxLocalization.currentXLocale);
  Rx<XTheme> currentTheme = Rx(PlayxTheme.currentTheme);
  final selectedTheme = ValueNotifier<ThemeMode>(ThemeMode.light);

  Rxn<XLocale> get currentLanguage => currentLocale;

  List<XLocale> get supportedLocales => PlayxLocalization.supportedXLocales;

  Rxn<UserInfo> get signedInUser => AppController.instance.currentUser;

  Subscription? get currentSubscription => AppController.instance.currentSubscription.value;

  final isNotificationsEnabled = true.obs;
  final soundAlertsEnabled = true.obs;
  final activeModuleTypes = <String>[].obs;

  final currentPage = ValueNotifier(SettingsPage.settings.index);
  final selectedSettingsTab = SettingsTabs.account.obs;
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    selectedTheme.value = PlayxTheme.currentTheme.id == DarkTheme.theme.id
        ? ThemeMode.dark
        : ThemeMode.light;
    tabController = TabController(
      length: SettingsTabs.visibleTabs.length,
      vsync: this,
      initialIndex: SettingsTabs.visibleTabs.indexOf(
        selectedSettingsTab.value,
      ),
    );
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      final tab = SettingsTabs.visibleTabs[tabController.index];
      if (selectedSettingsTab.value != tab) {
        selectedSettingsTab.value = tab;
      }
    });
    ever(selectedSettingsTab, (tab) {
      final index = SettingsTabs.visibleTabs.indexOf(tab);
      if (index >= 0 && tabController.index != index) {
        tabController.animateTo(index);
      }
    });
    unawaited(_loadPreferenceSettings());
  }

  Future<void> _loadPreferenceSettings() async {
    final prefs = MyPreferenceManger.instance;
    isNotificationsEnabled.value = await prefs.isNotificationsEnabled();
    soundAlertsEnabled.value = await prefs.isSoundAlertsEnabled();
    activeModuleTypes.assignAll(await prefs.getActiveModuleTypes());
  }

  Future<void> toggleNotifications(bool value) async {
    isNotificationsEnabled.value = value;
    await MyPreferenceManger.instance.saveNotificationsEnabled(value);
    HapticFeedback.selectionClick();
  }

  Future<void> toggleSoundAlerts(bool value) async {
    soundAlertsEnabled.value = value;
    await MyPreferenceManger.instance.saveSoundAlertsEnabled(value);
    HapticFeedback.selectionClick();
  }

  Future<void> toggleModule(AppModule module, bool isEnabled) async {
    if (isEnabled) {
      if (!activeModuleTypes.contains(module.type)) {
        activeModuleTypes.add(module.type);
      }
    } else {
      activeModuleTypes.remove(module.type);
    }
    final modules = <AppModule>[];
    for (final type in activeModuleTypes) {
      final enabled = AppModules.findByType(type);
      if (enabled != null) modules.add(enabled);
    }
    await AppController.instance.updateAppModules(modules: modules);
    HapticFeedback.selectionClick();
  }

  @override
  void onClose() {
    tabController.dispose();
    selectedTheme.dispose();
    super.onClose();
  }

  void handleLanguageSelection(XLocale locale, [BuildContext? context]) {
    currentLocale.value = locale;
    PlayxLocalization.updateTo(locale, forceAppUpdate: true);
  }

  Future<void> selectTheme(
    ThemeMode mode, {
    required BuildContext context,
  }) async {
    if (mode == selectedTheme.value) return;
    try {
      await PlayxTheme.updateByThemeMode(
        mode: mode,
        animation: PlayxThemeClipperAnimation(context: context),
      );
      selectedTheme.value = mode;
      currentTheme.value = PlayxTheme.currentTheme;
      HapticFeedback.selectionClick();
    } catch (_) {
      Alert.error(message: AppTrans.failedToUpdateTheme);
    }
  }

  Future<void> handleThemeSelection(
    XTheme theme, {
    BuildContext? context,
  }) async {
    final animation = PlayxThemeClipperAnimation(context: context);
    AppNavigation.pop();
    await Future.delayed(const Duration(milliseconds: 500));
    await PlayxTheme.updateTo(
      theme,
      animation: animation,
    );
    currentTheme.value = theme;
  }

  void handleLogOutTap() {
    AppController.instance.handleLogout();
  }

  void showChangePasswordDialog(BuildContext context) {
    change_password.showChangePasswordDialog(context);
  }

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
    ];

    return CustomModal.showModal(
      context: context,
      pageListBuilder: (context) => settingsPages,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
      pageIndexNotifier: currentPage,
    );
  }

  Future<void> showSettingsModalPageSheet(
    BuildContext context,
    SliverWoltModalSheetPage page,
  ) {
    return CustomModal.showPageModal(
      context: context,
      pageBuilder: (context) => page,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
    );
  }

  void closeSettingsModalSheet() {
    AppNavigation.pop();
    currentPage.value = SettingsPage.settings.index;
  }
}
