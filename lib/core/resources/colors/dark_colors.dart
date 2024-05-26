import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_colors.dart';

class DarkColors extends AppColors {
  // static final ColorScheme scheme = Seedcontext.colors.fromSeeds(
  //   primaryKey:  AppColors.primaryKey,
  //   brightness: Brightness.dark,
  //   tones: FlexTones.vivid(Brightness.dark)
  //       .onMainsUseBW()
  //       .onSurfacesUseBW(),
  // );

  static const ColorScheme scheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.black,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    surface: Color(0xFF121212),
    onSurface: Colors.white,
  );

  DarkColors() : super(colorScheme: scheme);

  @override
  Color get appBar => PlayxColors.black;

  @override
  Color? get subtitleTextColor => Colors.grey[400];

  @override
  Color? get chipBackgroundColor => Colors.grey[700];

  @override
  Color? get buttonBackgroundColor => PlayxColors.white;

  @override
  Color? get bottomBarUnselectedColor => Colors.grey[600];

  @override
  Color? get onButtonColor => PlayxColors.black;

  @override
  Color? get bottomBarShadowColor => Colors.transparent;

  @override
  Color get onAppBar => PlayxColors.white;

  @override
  Color? get onChipBackgroundColor => Colors.white;

  @override
  Color? get disabledButtonBackgroundColor => Colors.grey[600];

  @override
  Color get cardBackgroundColor => const Color(0xFF3A3A3A);

  @override
  Gradient? get backgroundGradient => null;

  @override
  Color get onBackgroundGradient => onBackground;
}
