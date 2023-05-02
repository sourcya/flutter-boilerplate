import 'package:playx/exports.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class AppThemeConfig extends XThemeConfig {
  @override
  List<XTheme> get themes => [
        LightTheme.theme,
        DarkTheme.theme,
      ];
}
