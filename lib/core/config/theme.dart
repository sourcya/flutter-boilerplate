import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/exports.dart';

import '../resources/colors.dart';

class AppThemeConfig extends XThemeConfig {
  static ColorScheme getColorScheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }

  static String lightTheme = 'light';
  static String darkTheme = 'dark';
  String lightThemeName = 'Light';
  String darkThemeName = 'Dark';

  @override
  List<XTheme> get themes => [
        XTheme(
          id: lightTheme,
          nameBuilder: () => lightThemeName,
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: AppColors.appBarLight,
            ),
            primaryColor: AppColors.primaryLight,
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryLight,
              secondary: AppColors.secondaryLight,
              background: AppColors.backgroundLight,
              surface: AppColors.surfaceLight,
              error: AppColors.errorLight,
              onPrimary: AppColors.onPrimaryLight,
              onSecondary: AppColors.onSecondaryLight,
              onBackground: AppColors.onBackgroundLight,
              onSurface: AppColors.onSurfaceLight,
              onError: AppColors.onErrorLight,
            ),
            scaffoldBackgroundColor: AppColors.backgroundLight,
            textTheme: GoogleFonts.rubikTextTheme(),
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
          ),
        ),
        XTheme(
          id: darkTheme,
          nameBuilder: () => darkThemeName,
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: AppColors.appBarDark,
            ),
            primaryColor: AppColors.primaryDark,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryDark,
              secondary: AppColors.secondaryDark,
              background: AppColors.backgroundDark,
              surface: AppColors.surfaceDark,
              error: AppColors.errorDark,
              onPrimary: AppColors.onPrimaryDark,
              onSecondary: AppColors.onSecondaryDark,
              onBackground: AppColors.onBackgroundDark,
              onSurface: AppColors.onSurfaceDark,
              onError: AppColors.onErrorDark,
            ),
            scaffoldBackgroundColor: AppColors.backgroundDark,
            textTheme: GoogleFonts.rubikTextTheme(),
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
          ),
        ),
      ];
}
