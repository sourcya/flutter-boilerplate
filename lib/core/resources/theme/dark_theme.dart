import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/dark_colors.dart';
import '../translation/app_locale_config.dart';
import '../translation/app_translations.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static String darkThemeId = 'dark';
  static String darkThemeName = AppTrans.darkTheme.tr;

  static DarkColors colors = DarkColors();


  static final themeData = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      // backgroundColor: colors.appBar,
    ),
    useMaterial3: true,
    colorScheme: colors.colorScheme,
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    cupertinoOverrideTheme:  CupertinoThemeData(
      barBackgroundColor: const Color(0xF0090909),
      primaryColor: colors.primary,
      primaryContrastingColor: colors.primaryContainer,
      scaffoldBackgroundColor: colors.background,
      brightness: Brightness.dark,
      textTheme:  CupertinoTextThemeData(primaryColor: colors.primary),
    ),

    applyElevationOverlayColor: true,
    fontFamily: fontFamily,
    textTheme: const TextTheme().apply(
      fontFamily: fontFamily,
    ),
  );


  static XTheme get theme => XTheme(
        id: darkThemeId,
        name: darkThemeName,
        colors: DarkColors(),
        theme: (locale) => themeData,
        cupertinoTheme: (locale) =>
            MaterialBasedCupertinoThemeData(materialTheme: themeData),
      );
}
