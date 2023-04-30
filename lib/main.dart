import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playx/playx.dart';

import 'core/config/app_config.dart';
import 'core/config/dependencies.dart';
import 'core/navigation/app_pages.dart';
import 'core/preferences/preference_manger.dart';
import 'core/resources/theme/theme.dart';
import 'core/resources/translation/app_locale.dart';

void main() async {
  await boot();
  final appConfig = AppConfig();

  await Playx.boot(
    themeConfig: AppThemeConfig(),
    appConfig: appConfig,
  );

  runApp(
    PlayXThemeBuilder(
      builder: (xTheme) {
        final selectedLang =
            MyPreferenceManger.instance.getAppSelectedLanguage();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          theme: xTheme.theme,
          locale: Get.locale ?? Locale(selectedLang),
          fallbackLocale: const Locale(AppLocale.englishLanguage),
          translations: AppLocale(),
          title: appConfig.appTitle,
        );
      },
    ),
  );
}
