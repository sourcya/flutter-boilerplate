import 'package:playx/playx.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

PlayxThemeConfig createThemeConfig() => PlayxThemeConfig(
      themes: [
        LightTheme.theme,
        DarkTheme.theme,
      ],
      initialThemeIndex: PlayxTheme.isDeviceInDarkMode() ? 1 : 0,
    );
