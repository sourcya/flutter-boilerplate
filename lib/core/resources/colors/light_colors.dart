import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:playx/playx.dart';

class LightColors extends AppColors {
  // static final ColorScheme scheme = SeedColorScheme.fromSeeds(
  //   primaryKey:  AppColors.primaryKey,
  // );

  // static final ColorScheme scheme = SeedColorScheme.fromSeeds(
  //   primaryKey: AppColors.blue,
  //   tones: FlexTones.chroma(Brightness.light)
  //       .onMainsUseBW()
  //       .onSurfacesUseBW()
  //       .surfacesUseBW(),

  static const ColorScheme scheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,

  );

  LightColors() : super(colorScheme: scheme);

  @override
  Color get containerBackgroundColor => XColors.white;

  @override
  Color get background => XColors.white;

  @override
  Color get error => XColors.red;

  @override
  Color get onBackground => XColors.black;

  @override
  Color get onError => XColors.white;

  @override
  Color get onPrimary => XColors.white;

  @override
  Color get onSecondary => XColors.white;

  @override
  Color get onSurface => XColors.black;

  @override
  Color get primary => Colors.black;

  @override
  Color get secondary => XColors.black;

  @override
  Color get surface => XColors.white;

  @override
  Color get appBar => XColors.white;

  @override
  Color? get chipBackgroundColor => Colors.grey;

  @override
  Color? get subtitleTextColor => Colors.grey[600];

  @override
  Color? get buttonBackgroundColor => primary;

  @override
  Color? get onButtonColor => XColors.white;

  @override
  Color? get bottomBarUnselectedColor => const Color(0XFFAFAFAF);

  @override
  Color? get bottomBarShadowColor => Colors.grey[300];

  @override
  Color get onAppBar => XColors.black;

  @override
  Color? get onChipBackgroundColor => Colors.white;
}
