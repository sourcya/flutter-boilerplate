part of '../ui.dart';

PlayxThemeConfig createThemeConfig() => PlayxThemeConfig(
      themes: [
        LightTheme.theme,
        DarkTheme.theme,
      ],
      initialThemeIndex: PlayxTheme.isDeviceInDarkMode() ? 1 : 0,
    );
