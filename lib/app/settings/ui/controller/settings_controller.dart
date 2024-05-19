part of '../imports/settings_imports.dart';

class SettingsController extends GetxController {
  Rxn<XLocale> currentLocale = Rxn(PlayxLocalization.currentXLocale);
  Rx<XTheme> currentTheme = Rx(PlayxTheme.currentTheme);

  List<XLocale> get supportedLocales => PlayxLocalization.supportedXLocales;

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
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.navigateFromSettingsToLogin();
    AppRouter.pop();
  }

  Future<void> showSettingsModalSheet(
    BuildContext context,
    SliverWoltModalSheetPage page,
  ) async {
    final List<SliverWoltModalSheetPage> settingsPages = [
      page,
    ];

    return CustomModal.showModal(
      context: context,
      pageListBuilder: (context) => settingsPages,
      onModalDismissedWithBarrierTap: closeSettingsModalSheet,
      pageIndexNotifier: ValueNotifier(0),
    );
  }

  void closeSettingsModalSheet() {
    AppRouter.pop();
  }
}
