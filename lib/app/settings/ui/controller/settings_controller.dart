part of '../imports/settings_imports.dart';

enum SettingsPage {
  settings,
  language,
  theme;
}

class SettingsController extends GetxController {
  Rxn<XLocale> currentLocale = Rxn(PlayxLocalization.currentXLocale);
  Rx<XTheme> currentTheme = Rx(PlayxTheme.currentTheme);

  List<XLocale> get supportedLocales => PlayxLocalization.supportedXLocales;

  final currentPage = ValueNotifier(SettingsPage.settings.index);

  CustomNavigationDrawerController get drawerController =>
      Get.find<CustomNavigationDrawerController>();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void handleLanguageSelection(XLocale locale) {
    currentLocale.value = locale;
    PlayxLocalization.updateTo(locale);
    AppRouter.pop();
  }

  Future<void> handleThemeSelection(
    XTheme theme, {
    BuildContext? context,
  }) async {
    AppRouter.pop();
    await Future.delayed(200.milliseconds);
    await PlayxTheme.updateTo(
      theme,
    );
    currentTheme.value = theme;
  }

  Future<void> handleLogOutTap() async {
    drawerController.updateLoginStatus(isLoggingOut: true);
    try {
      await AuthRepository().logout(logOutFromAuth0: false);
    } catch (e) {
      Alert.error(message: e.toString());
    }
    await Future.delayed(200.milliseconds);
    AppNavigation.navigateToSplash();
    drawerController.updateLoginStatus(isLoggingOut: false);
  }

  Future<void> showSettingsModalSheet(
    BuildContext context,
  ) async {
    final List<SliverWoltModalSheetPage> settingsPages = [
      SettingsView.buildSettingsModalSheetPage(this, context),
      BuildSettingsLanguageWidget.buildModalPage(this, context),
      BuildSettingsThemeWidget.buildModalPage(this, context),
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
  ) async {
    return CustomModal.showPageModal(
      context: context,
      pageBuilder: (context) => page,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
    );
  }

  void closeSettingsModalSheet() {
    AppRouter.pop();
    currentPage.value = SettingsPage.settings.index;
  }
}
