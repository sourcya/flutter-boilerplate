import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/dark_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/playx.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static String darkTheme = 'dark';
  static String darkThemeName = 'Dark';

  static DarkColorScheme colorScheme = DarkColorScheme();

  static XTheme get theme => XTheme(
        id: darkTheme,
        nameBuilder: () => darkThemeName,
        colorScheme: DarkColorScheme(),
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: colorScheme.appBar,
          ),
          primaryColor: colorScheme.primary,
          colorScheme: ColorScheme.dark(
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
