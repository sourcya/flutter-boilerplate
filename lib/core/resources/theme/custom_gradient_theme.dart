import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../colors/custom_gradient_theme_colors.dart';
import '../translation/app_translations.dart';

class CustomGradientTheme {
  const CustomGradientTheme._();
  static String themeId = 'gradient-theme';
  static String themeNameKey = AppTrans.gradientTheme;

  static CustomGradientThemeColors colors = CustomGradientThemeColors();

  static final themeData = ThemeData(
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

  static XTheme get theme => XTheme(
        id: themeId,
        name: themeNameKey,
        colors: colors,
        themeData: themeData,
        cupertinoThemeData:
            MaterialBasedCupertinoThemeData(materialTheme: themeData),
      );
}
