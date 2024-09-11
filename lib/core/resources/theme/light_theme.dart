import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/light_colors.dart';
import '../translation/app_translations.dart';

// ignore: avoid_classes_with_only_static_members
class LightTheme {
  static String lightThemeId = 'light';
  static String lightThemeNameKey = AppTrans.lightTheme;

  static LightColors colors = LightColors();

  static ThemeData get themeData => ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          barBackgroundColor: const Color(0xF0F9F9F9),
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
      );

  static XTheme get theme => XTheme.builder(
        id: lightThemeId,
        name: lightThemeNameKey,
        colors: colors,
        initialTheme: themeData,
        themeBuilder: (locale) => themeData,
        cupertinoThemeBuilder: (locale) => MaterialBasedCupertinoThemeData(
          materialTheme: themeData,
        ),
      );
}
