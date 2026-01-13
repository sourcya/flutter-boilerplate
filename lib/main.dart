import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/preferences/env_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

const enableDevicePreviewOnWeb = true;

void main() {
  Playx.runPlayx(
    appConfigBuilder: () => AppConfig(),
    themeConfigBuilder: () => AppThemeConfig.createThemeConfig(),
    localeConfigBuilder: () => AppLocaleConfig.createLocaleConfig(),
    envSettingsBuilder: () =>
        const PlayxEnvSettings(fileName: 'assets/env/keys.env'),
    securePrefsSettings: const PlayxSecurePrefsSettings(
      createSecurePrefs: false,
      androidOptions: AndroidOptions.defaultOptions,
    ),
    sentryOptions: (options) async {
      options.dsn = await EnvManger.instance.sentryKey;
      options.tracesSampleRate = 1.0;
      options.attachScreenshot = true;
      options.captureFailedRequests = true;
    },
    app: kIsWeb && enableDevicePreviewOnWeb
        ? DevicePreview(builder: (context) => const MyApp())
        : const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return Center(
            child: PlayxPlatformApp(
              preferredOrientations: const [
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.portraitUp,
              ],
              themeSettings: PlayxThemeSettings(
                theme: ThemeData(fontFamily: fontFamily(context: context)),
              ),
              navigationSettings: PlayxNavigationSettings.goRouter(
                goRouter: AppPages.router,
                builder: kIsWeb && enableDevicePreviewOnWeb
                    ? DevicePreview.appBuilder
                    : null,
              ),
              screenSettings: const PlayxScreenSettings(
                ensureScreenSize: true,
                fontSizeResolver: FontSizeResolvers.radius,
                designSize: Size(430.0, 932.0),
                useInheritedMediaQuery: true,
              ),
              appSettings: PlayxAppSettings(
                title: AppTrans.appName.tr(),
                scrollBehavior: DefaultAppScrollBehavior(),
              ),
            ),
          );
        },
      ),
    );
  }
}
