part of '../imports/settings_imports.dart';

enum SettingsPage { settings, language, theme, privacy, terms }

class SettingsController extends GetxController {
  Rxn<XLocale> currentLocale = Rxn(PlayxLocalization.currentXLocale);
  Rx<XTheme> currentTheme = Rx(PlayxTheme.currentTheme);

  List<XLocale> get supportedLocales => PlayxLocalization.supportedXLocales;

  final currentPage = ValueNotifier(SettingsPage.settings.index);

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void handleLanguageSelection(XLocale locale) {
    currentLocale.value = locale;
    PlayxLocalization.updateTo(locale);
    PlayxNavigation.pop();
  }

  Future<void> handleThemeSelection(
    XTheme theme, {
    BuildContext? context,
  }) async {
    PlayxNavigation.pop();
    await Future.delayed(const Duration(milliseconds: 500));
    await PlayxTheme.updateTo(
      theme,
      animation: PlayxThemeClipperAnimation(),
    );
    currentTheme.value = theme;
  }

  Future<void> handleLogOutTap() async {
    AppController.instance.handleLogout();
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
    PlayxNavigation.pop();
    currentPage.value = SettingsPage.settings.index;
  }
}
