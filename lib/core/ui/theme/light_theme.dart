part of '../ui.dart';

// ignore: avoid_classes_with_only_static_members
class LightTheme {
  static const String lightThemeId = 'light';
  static const String lightThemeName = AppTrans.lightTheme;

  static LightColors colors = LightColors();

  static ThemeData get themeData => ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: colors.appBar,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          barBackgroundColor: colors.primary.withValues(alpha: .93),
          primaryColor: colors.primary,
          primaryContrastingColor: colors.primaryContainer,
          scaffoldBackgroundColor: colors.surface,
          brightness: Brightness.light,
          textTheme:
              const CupertinoTextThemeData(primaryColor: CupertinoColors.label),
        ),
        useMaterial3: true,
        colorScheme: colors.colorScheme,
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        fontFamily: fontFamily(),
        textTheme: const TextTheme().apply(fontFamily: fontFamily()),
        splashColor: colors.primary.withValues(alpha: .5),
      );

  static XTheme get theme => XTheme.builder(
        id: lightThemeId,
        name: lightThemeName,
        colors: colors,
        initialTheme: themeData,
        themeBuilder: (locale) => themeData,
        cupertinoThemeBuilder: (locale) => MaterialBasedCupertinoThemeData(
          materialTheme: themeData,
        ),
      );
}
