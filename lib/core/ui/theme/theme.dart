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

extension ThemeExtension on XTheme {
  String get displayName => name;

  String get shortLabel => id == LightTheme.theme.id
      ? AppTrans.lightThemeShortLabel
      : AppTrans.darkThemeShortLabel;
}
