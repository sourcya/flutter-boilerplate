import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const envSettings = PlayxEnvSettings(fileName: 'assets/env/keys.env');
  const fallbackEnvSettings = PlayxEnvSettings(
    fileName: 'assets/env/keys.env.example',
  );
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final hasEnvFile = assetManifest.listAssets().contains(envSettings.fileName);
  final resolvedEnvSettings = hasEnvFile ? envSettings : fallbackEnvSettings;
  await PlayxEnv.load(fileName: resolvedEnvSettings.fileName);
  final sentryDsn = await PlayxEnv.getString('SENTRY_KEY');

  return Playx.runPlayx(
    appConfigBuilder: () => AppConfig(),
    themeConfigBuilder: () => AppThemeConfig.createThemeConfig(),
    localeConfigBuilder: () => AppLocaleConfig.createLocaleConfig(),
    envSettingsBuilder: () => resolvedEnvSettings,
    sentryOptions: sentryDsn.isEmpty
        ? null
        : (options) {
            options.dsn = sentryDsn;
            options.tracesSampleRate = 1.0;
            options.attachScreenshot = true;
            options.captureFailedRequests = true;
          },
    appRunner: () => runApp(const AppView()),
  );
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
            screenSettings: PlayxScreenSettings(
              fontSizeResolver: FontSizeResolvers.radius,
              designSize: context.currentDesignSize,
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
