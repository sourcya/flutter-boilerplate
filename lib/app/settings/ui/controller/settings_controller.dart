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
    Get.back();
  }

  void handleThemeSelection(XTheme theme) {
    PlayxTheme.updateTo(theme);
    currentTheme.value = theme;
    Get.back();
  }

  Future<void> handleLogOutTap() async {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().resetNavigation();
    }
    final preferenceManger = MyPreferenceManger.instance;
    await preferenceManger.signOut();
    AppNavigation.instance.navigateFromSettingsToLogin();
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
    Get.back();
  }
}
