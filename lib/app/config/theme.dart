import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/exports.dart';

class AppThemeConfig extends XThemeConfig {
  @override
  List<XTheme> get themes => [
        XTheme(
          id: 'light',
          nameBuilder: () => 'Light',
          theme: ThemeData.light().copyWith(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Color(0xFF00354f),
            ),
            primaryColor: const Color(0xFF00354f),
            colorScheme: const ColorScheme.dark(
              secondary: Color(0xFFd65a2e),
            ),
            scaffoldBackgroundColor: const Color(0xFF00354f),
            textTheme: GoogleFonts.rubikTextTheme(),
            sliderTheme: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
            ),
          ),
        ),
      ];
}
