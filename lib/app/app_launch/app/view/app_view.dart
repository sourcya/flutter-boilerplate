import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_pages.dart';
import '../../../../core/resources/translation/app_translations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayxPlatformApp(
      title: AppTrans.appName.tr,
      navigationSettings: PlayxNavigationSettings(
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
      screenSettings: const PlayxScreenSettings(
        fontSizeResolver: FontSizeResolvers.radius,
      ),
      scrollBehavior: DefaultAppScrollBehavior(),
    );
  }
}
