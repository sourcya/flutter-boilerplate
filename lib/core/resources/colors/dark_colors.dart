import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_colors.dart';

class DarkColors extends AppColors {
  // static final ColorScheme scheme = SeedColorScheme.fromSeeds(
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
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
  );

  DarkColors() : super(colorScheme: scheme);

  @override
  Color get containerBackgroundColor => XColors.black;

  @override
  Color get appBar => XColors.black;

  @override
  Color? get subtitleTextColor => Colors.grey[400];

  @override
  Color? get chipBackgroundColor => Colors.grey[700];

  @override
  Color? get buttonBackgroundColor => XColors.white;

  @override
  Color? get bottomBarUnselectedColor => Colors.grey[600];

  @override
  Color? get onButtonColor => XColors.black;

  @override
  Color? get bottomBarShadowColor => Colors.transparent;

  @override
  Color get onAppBar => XColors.white;

  @override
  Color? get onChipBackgroundColor => Colors.white;
}
