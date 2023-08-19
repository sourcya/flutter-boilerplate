
part of '../imports/settings_imports.dart';

class SettingsController extends GetxController {
  Rxn<XLocale> currentLocale= Rxn(PlayxLocalization.currentXLocale);
  Rx<XTheme> currentTheme = Rx(AppTheme.xTheme);

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
    AppTheme.updateTo(theme);
    currentTheme.value = theme;
    Get.back();
  }


  }

