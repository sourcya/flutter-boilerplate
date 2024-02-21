import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/app/controller/app_controller.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_pages.dart';
import '../../../../core/resources/translation/app_translations.dart';

class MyApp extends GetView<AppController> {
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
