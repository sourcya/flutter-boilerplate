import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'core/config/app_config.dart';
import 'core/navigation/app_pages.dart';
import 'core/resources/theme/theme.dart';
import 'core/resources/translation/app_locale_config.dart';
import 'core/resources/translation/app_translations.dart';

void main() async {
  final appConfig = AppConfig();

  Playx.runPlayx(
    appConfig: appConfig,
    themeConfig: AppThemeConfig(),
    localeConfig: AppLocaleConfig(),
    app: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayxMaterialApp(
              useInheritedMediaQuery: true,
              initialRoute: AppPages.initial,
              getPages: AppPages.routes,
              title: AppTrans.appName.tr,
    );
  }
}
