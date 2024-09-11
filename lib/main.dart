import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/navigation/app_pages.dart';
import 'package:playx/playx.dart';

import 'core/config/app_config.dart';
import 'core/resources/theme/theme.dart';
import 'core/resources/translation/app_locale_config.dart';
import 'core/resources/translation/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Playx.runPlayx(
    appConfig: AppConfig(),
    themeConfig: createThemeConfig(),
    localeConfig: createLocaleConfig(),
    envSettings: const PlayxEnvSettings(
      fileName: 'assets/env/keys.env',
    ),
    app: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return PlayxPlatformApp(
            preferredOrientations: const [
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.portraitUp,
            ],
            navigationSettings: PlayxNavigationSettings.goRouter(
              goRouter: AppPages.router,
            ),
            screenSettings: const PlayxScreenSettings(
              fontSizeResolver: FontSizeResolvers.radius,
            ),
            appSettings: PlayxAppSettings(
              title: AppTrans.appName.tr(),
              scrollBehavior: DefaultAppScrollBehavior(),
            ),
          );
        },
      ),
    );
  }
}
