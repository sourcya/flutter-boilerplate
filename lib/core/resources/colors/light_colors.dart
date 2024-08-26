import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_colors.dart';

class LightColors extends AppColors {
  // static final ColorScheme scheme = Seedcontext.colors.fromSeeds(
  //   primaryKey:  AppColors.primaryKey,
  // );

  static final ColorScheme scheme = SeedColorScheme.fromSeeds(
    primaryKey: Colors.white,
    tones: FlexTones.chroma(Brightness.light)
        .onMainsUseBW()
        .onSurfacesUseBW()
        .surfacesUseBW(),
  );

  LightColors() : super(colorScheme: scheme);

  @override
  Color get appBar => PlayxColors.white;

  @override
  Color? get chipBackgroundColor => Colors.grey;

  @override
  Color? get subtitleTextColor => Colors.grey[600];

  @override
  Color? get buttonBackgroundColor => primary;

  @override
  Color? get onButtonColor => PlayxColors.white;

  @override
  Color? get bottomBarUnselectedColor => const Color(0XFFAFAFAF);

  @override
  Color? get bottomBarShadowColor => Colors.grey[300];

  @override
  Color get onAppBar => PlayxColors.black;

  @override
  Color? get onChipBackgroundColor => Colors.white;

  @override
  Color? get disabledButtonBackgroundColor => Colors.grey[300];

  @override
  Gradient? get backgroundGradient => null;

  @override
  Color get onBackgroundGradient => onSurface;
}
