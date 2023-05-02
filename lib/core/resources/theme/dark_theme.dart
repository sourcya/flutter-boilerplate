import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/exports.dart';

import '../colors.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static String darkTheme = 'dark';
  static String darkThemeName = 'Dark';

  static XTheme get theme => XTheme(
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
      );
}
