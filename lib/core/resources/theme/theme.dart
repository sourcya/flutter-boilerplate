import 'package:playx/playx.dart';

import '../translation/app_translations.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class AppThemeConfig extends XThemeConfig {
  @override
  List<XTheme> get themes => [
        LightTheme.theme,
        DarkTheme.theme,
      ];
}
extension XThemeExtension on XTheme{

  String get displayName => id == DarkTheme.darkThemeId ? AppTrans.darkTheme.tr : AppTrans.lightTheme.tr;

}