import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/exports.dart';

import '../colors.dart';

// ignore: avoid_classes_with_only_static_members
abstract class LightTheme {
  static String lightTheme = 'light';
  static String lightThemeName = 'Light';

  static XTheme get theme => XTheme(
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
      );
}
