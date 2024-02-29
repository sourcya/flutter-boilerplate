part of '../imports/settings_imports.dart';

class SettingsController extends GetxController {
  Rxn<XLocale> currentLocale = Rxn(PlayxLocalization.currentXLocale);
  Rx<XTheme> currentTheme = Rx(PlayxTheme.xTheme);

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

  void handleThemeSelection(XTheme theme) {
    PlayxTheme.updateTo(theme);
    currentTheme.value = theme;
    AppRouter.pop();
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
