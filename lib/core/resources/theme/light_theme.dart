import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/light_colors.dart';
import '../translation/app_locale_config.dart';
import '../translation/app_translations.dart';

// ignore: avoid_classes_with_only_static_members
class LightTheme {
  static String lightThemeId = 'light';
  static String lightThemeNameKey = AppTrans.lightTheme;

  static LightColors colors = LightColors();

  static final themeData = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    cupertinoOverrideTheme:  CupertinoThemeData(
      barBackgroundColor: const Color(0xF0F9F9F9),
      primaryColor: colors.primary,
      primaryContrastingColor: colors.primaryContainer,
      scaffoldBackgroundColor: colors.background,
      brightness: Brightness.light,
      textTheme: const CupertinoTextThemeData(primaryColor: CupertinoColors.label),
    ),
    useMaterial3: true,
    colorScheme: colors.colorScheme,
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    fontFamily: fontFamily,
    textTheme: const TextTheme().apply(fontFamily: fontFamily),
  );



  static XTheme get theme => XTheme(
        id: lightThemeId,
        name: lightThemeNameKey,
        colors: colors,
        theme: (locale) => themeData,
        cupertinoTheme: (locale) => MaterialBasedCupertinoThemeData(
          materialTheme: themeData,
        ),
      );
}
