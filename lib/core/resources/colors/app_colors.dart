import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

/// This is base class for creating a color scheme for each theme.
/// You can create this class of you want to add more colors that will be implemented in each theme color scheme
/// or if you want to add const colors for each theme.
/// If you don't need this functionality you can make each theme color scheme extends `XColorScheme` class
/// You can define a function to get the color scheme like this:
/// ```dart
///  BaseColorScheme get colorScheme => AppTheme.colorScheme as BaseColorScheme;
///  final primary = context.colors.primary;
///  ```
///  Now you can access each theme color.
abstract class AppColors extends PlayxColors {
  final ColorScheme colorScheme;

  AppColors({
    required this.colorScheme,
  }) : super.fromColorScheme(scheme: colorScheme);

  ///Colors that needs to implemented for each theme.

  Color get appBar;

  Color get onAppBar;

  Color? get subtitleTextColor;

  Color? get chipBackgroundColor;

  Color? get onChipBackgroundColor;

  Color? get buttonBackgroundColor;

  Color? get onButtonColor;

  Color? get bottomBarUnselectedColor;

  Color? get bottomBarShadowColor;

  Color? get disabledButtonBackgroundColor;
  Gradient? get backgroundGradient;

  Color get onBackgroundGradient;

  static const Color blueGrey = Color(0xFF728295);

  ///Colors that needs to is used for each theme.
  static const Color blue = Colors.blue;

  static const Color primaryKey = Colors.black;
}

extension AppColorsExtension on BuildContext {
  AppColors get colors => playxColors as AppColors;
}
