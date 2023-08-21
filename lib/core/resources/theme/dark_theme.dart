import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/dark_color_scheme.dart';
import '../translation/app_locale_config.dart';
import '../translation/app_translations.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static String darkThemeId = 'dark';
  static String darkThemeName = AppTrans.darkTheme.tr;

  static DarkColorScheme colorScheme = DarkColorScheme();

  static XTheme get theme => XTheme(
    id: darkThemeId,
    name: darkThemeName,
    colorScheme: DarkColorScheme(),
    theme: (locale)=> ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: colorScheme.appBar,
        ),
        primaryColor: colorScheme.primary,
        colorScheme: ColorScheme.dark(
          primary: colorScheme.primary,
          secondary: colorScheme.secondary,
          background: colorScheme.background,
          surface: colorScheme.surface,
          error: colorScheme.error,
          onPrimary: colorScheme.onPrimary,
          onSecondary: colorScheme.onSecondary,
          onBackground: colorScheme.onBackground,
          onSurface: colorScheme.onSurface,
          onError: colorScheme.onError,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
        applyElevationOverlayColor: true,
        fontFamily:fontFamily,
        textTheme: const TextTheme().apply(
            fontFamily: fontFamily
        ,),
    ),
  );
}
