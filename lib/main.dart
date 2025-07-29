import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

void main() {
  Playx.runPlayx(
    appConfigBuilder: () => AppConfig(),
    themeConfigBuilder: () => createThemeConfig(),
    localeConfigBuilder: () => createLocaleConfig(),
    envSettingsBuilder: () => const PlayxEnvSettings(
      fileName: 'assets/env/keys.env',
    ),
    securePrefsSettings: const PlayxSecurePrefsSettings(
      androidOptions: AndroidOptions(
        encryptedSharedPreferences: true,
        resetOnError: true,
      ),
    ),
    sentryOptions: (options) async {
      options.dsn = await EnvManger.instance.sentryKey;
      options.tracesSampleRate = 1.0;
      options.attachScreenshot = true;
      options.captureFailedRequests = true;
    },
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
