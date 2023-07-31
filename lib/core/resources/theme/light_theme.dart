import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/playx.dart';

import '../colors/light_color_scheme.dart';

// ignore: avoid_classes_with_only_static_members
class LightTheme {
  static String lightThemeId = 'light';
  static String lightThemeName = 'Light';

  static LightColorScheme colorScheme = LightColorScheme();

  static XTheme get theme => XTheme(
        id: lightThemeId,
        name: lightThemeName,
        colorScheme: colorScheme,
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: colorScheme.appBar,
          ),
          primaryColor: colorScheme.primary,
          colorScheme: ColorScheme.light(
            primary: colorScheme.primary,
            secondary: colorScheme.secondary,
            background: colorScheme.background,
            surface: colorScheme.surface,
            error: colorScheme.error,
            onPrimary: colorScheme.onPrimary,
            onSecondary: colorScheme.onSecondary,
            onBackground: colorScheme.onBackground,
            onSurface: colorScheme.onSurface,
            onError: colorScheme.onError,
          ),
          scaffoldBackgroundColor: colorScheme.background,
          textTheme: GoogleFonts.rubikTextTheme(),
          sliderTheme: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
          ),
        ),
      );
}
