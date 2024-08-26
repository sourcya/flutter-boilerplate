import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/dark_colors.dart';
import '../translation/app_translations.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static String darkThemeId = 'dark';
  static String darkThemeName = AppTrans.darkTheme;

  static DarkColors colors = DarkColors();

  static ThemeData get themeData => ThemeData(
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
        cupertinoOverrideTheme: CupertinoThemeData(
          barBackgroundColor: const Color(0xF0090909),
          primaryColor: colors.primary,
          primaryContrastingColor: colors.primaryContainer,
          scaffoldBackgroundColor: colors.surface,
          brightness: Brightness.dark,
          textTheme: CupertinoTextThemeData(primaryColor: colors.primary),
        ),
        applyElevationOverlayColor: true,
        extensions: const [
          WoltModalSheetThemeData(
            modalElevation: 4,
          ),
        ],
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
