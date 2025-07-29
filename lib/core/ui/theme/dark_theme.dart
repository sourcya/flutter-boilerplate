part of '../ui.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static String darkThemeId = 'dark';
  static String darkThemeName = AppTrans.darkTheme;

  static DarkColors colors = DarkColors();

  static ThemeData get themeData => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: colors.appBar,
          scrolledUnderElevation: 2,
          elevation: 2,
        ),
        useMaterial3: true,
        colorScheme: colors.colorScheme,
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          barBackgroundColor: colors.primary.withValues(alpha: .93),
          primaryColor: colors.primary,
          primaryContrastingColor: colors.primaryContainer,
          scaffoldBackgroundColor: colors.surface,
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(primaryColor: colors.primary),
        ),
        splashColor: colors.primary.withValues(alpha: .5),
        applyElevationOverlayColor: true,
        fontFamily: fontFamily(),
        textTheme: const TextTheme().apply(fontFamily: fontFamily()),
      );

  static XTheme get theme => XTheme.builder(
        id: darkThemeId,
        name: darkThemeName,
        colors: DarkColors(),
        initialTheme: themeData,
        themeBuilder: (locale) => themeData,
        cupertinoThemeBuilder: (locale) =>
            MaterialBasedCupertinoThemeData(materialTheme: themeData),
        isDark: true,
      );
}
