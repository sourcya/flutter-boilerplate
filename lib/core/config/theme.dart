import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/exports.dart';

import '../resources/colors.dart';

class AppThemeConfig extends XThemeConfig {
  @override
  List<XTheme> get themes => [
        XTheme(
          id: 'light',
          nameBuilder: () => 'Light',
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: AppColors.background,
            ),
            primaryColor: AppColors.primary,
            colorScheme: const ColorScheme.dark(
              secondary: AppColors.secondary,
            ),
            scaffoldBackgroundColor: AppColors.background,
            textTheme: GoogleFonts.rubikTextTheme(),
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
          ),
        ),
      ];
}
