import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_colors.dart';

class CustomBluePurpleGradientThemeColors extends AppColors {
  CustomBluePurpleGradientThemeColors()
      : super(
          colorScheme: SeedColorScheme.fromSeeds(
            primaryKey: const Color(
              0xFF667eea,
            ),
            secondaryKey: const Color(0xFF764ba2),
          ),
        );

  @override
  Color get appBar => PlayxColors.black;

  @override
  Color? get subtitleTextColor => Colors.grey[600];

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
  Color? get disabledButtonBackgroundColor => Colors.grey[300];

  // Gradient blue and purple
  @override
  Gradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF667eea),
          Color(0xFF764ba2),
        ],
      );

  @override
  Color get onBackgroundGradient => PlayxColors.white;
}
