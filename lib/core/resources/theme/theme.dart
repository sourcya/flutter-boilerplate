import 'package:playx/playx.dart';

import 'custom_blue_purple_gradient_theme.dart';
import 'custom_gradient_theme.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

PlayxThemeConfig createThemeConfig() => PlayxThemeConfig(
      themes: [
        LightTheme.theme,
        DarkTheme.theme,
        CustomGradientTheme.theme,
        CustomBluePurpleGradientTheme.theme,
      ],
      initialThemeIndex: PlayxTheme.isDeviceInDarkMode() ? 1 : 0,
    );
