import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/custom_blue_purple_gradient_theme_colors.dart';
import '../translation/app_translations.dart';

class CustomBluePurpleGradientTheme {
  const CustomBluePurpleGradientTheme._();

  static String themeId = 'blue-purple-gradient-theme';
  static String themeName = AppTrans.bluePurpleGradientTheme;

  static CustomBluePurpleGradientThemeColors colors =
      CustomBluePurpleGradientThemeColors();

  static final themeData = ThemeData(
    brightness: Brightness.light,
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
  );

  static XTheme get theme => XTheme(
        id: themeId,
        name: themeName,
        colors: colors,
        themeData: themeData,
        cupertinoThemeData:
            MaterialBasedCupertinoThemeData(materialTheme: themeData),
      );
}
