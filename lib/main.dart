import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return PlayXThemeBuilder(
      builder: (xTheme) {
        final selectedLang =
            MyPreferenceManger.instance.getAppSelectedLanguage();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context , child) {
            return GetMaterialApp(
              useInheritedMediaQuery: true,
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.initial,
              getPages: AppPages.routes,
              theme: xTheme.theme,
              locale: Get.locale ?? Locale(selectedLang),
              fallbackLocale: const Locale(AppLocale.englishLanguage),
              translations: AppLocale(),
              title: AppTrans.appName.tr,
            );
          },
        );
      },
    );
  }
}
