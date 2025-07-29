part of '../ui.dart';

class AppThemeConfig {
  AppThemeConfig._();

  static PlayxThemeConfig createThemeConfig() => PlayxThemeConfig(
        themes: [
          LightTheme.theme,
          DarkTheme.theme,
        ],
        initialThemeIndex: PlayxTheme.isDeviceInDarkMode() ? 1 : 0,
      );
}
