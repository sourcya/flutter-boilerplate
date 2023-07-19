import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'core/config/app_config.dart';
import 'core/navigation/app_pages.dart';
import 'core/preferences/preference_manger.dart';
import 'core/resources/theme/theme.dart';
import 'core/resources/translation/app_locale.dart';
import 'core/resources/translation/app_translations.dart';

void main() async {
  final appConfig = AppConfig();

  Playx.runPlayx(
    appConfig: appConfig,
    themeConfig: AppThemeConfig(),
    app: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedLang =
    MyPreferenceManger.instance.getAppSelectedLanguage();
    return PlayxMaterialApp(
              useInheritedMediaQuery: true,
              initialRoute: AppPages.initial,
              getPages: AppPages.routes,
              locale: Get.locale ?? Locale(selectedLang),
              fallbackLocale: const Locale(AppLocale.englishLanguage),
              translations: AppLocale(),
              title: AppTrans.appName.tr,
    );
  }
}
