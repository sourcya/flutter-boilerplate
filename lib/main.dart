import 'package:playx/playx.dart';

import 'app/app_launch/app/view/app_view.dart';
import 'core/config/app_config.dart';
import 'core/resources/theme/theme.dart';
import 'core/resources/translation/app_locale_config.dart';

void main() async {
  final appConfig = AppConfig();
  Playx.runPlayx(
    appConfig: appConfig,
    themeConfig: AppThemeConfig(),
    localeConfig: AppLocaleConfig(),
    envSettings: const PlayxEnvSettings(
      fileName: 'assets/env/keys.env',
    ),
    app: const MyApp(),
  );
}
