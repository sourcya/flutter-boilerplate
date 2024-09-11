import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_colors.dart';

class DarkColors extends AppColors {
  static final ColorScheme scheme = SeedColorScheme.fromSeeds(
    primaryKey: Colors.black,
    brightness: Brightness.dark,
    tones: FlexTones.chroma(Brightness.dark)
        .onMainsUseBW()
        .onSurfacesUseBW()
        .surfacesUseBW(),
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
  Gradient? get backgroundGradient => null;

  @override
  Color get onBackgroundGradient => onSurface;
}
