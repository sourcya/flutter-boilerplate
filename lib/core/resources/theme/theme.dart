import 'package:playx/playx.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class AppThemeConfig extends XThemeConfig {
  @override
  List<XTheme> get themes => [
        LightTheme.theme,
        DarkTheme.theme,
      ];

  @override
  int get initialThemeIndex => PlayxTheme.isDeviceInDarkMode() ? 1 : 0;
}
