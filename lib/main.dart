import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/config/app.dart';
import 'package:flutter_boilerplate/app/config/dependencies.dart';
import 'package:flutter_boilerplate/app/config/lang.dart';
import 'package:flutter_boilerplate/app/config/theme.dart';
import 'package:flutter_boilerplate/app/routes/app_pages.dart';
import 'package:playx/playx.dart';

void main() async {
  await boot();
  await Playx.runPlayX(
    themeConfig: AppThemeConfig(),
    appConfig: AppConfig(),
    app: PlayXThemeBuilder(
      builder: (xTheme) {
        final selectedLang = Prefs.getString('lang') ?? 'en';
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: xTheme.theme,
          locale: Get.locale ?? Locale(selectedLang),
          translations: AppTrans(),
        );
      },
    ),
  );
  // await Prefs.clear();
}
