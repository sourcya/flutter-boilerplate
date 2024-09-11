import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_colors.dart';

class CustomGradientThemeColors extends AppColors {
  CustomGradientThemeColors()
      : super(
          colorScheme: SeedColorScheme.fromSeeds(
            primaryKey: const Color(
              0xFFff7e5f,
            ),
            secondaryKey: const Color(0xFFfeb47b),
          ),
        );

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
  Gradient? get backgroundGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFfeb47b),
          Color(0xFFff7e5f),
        ],
      );

  @override
  Color get onBackgroundGradient => PlayxColors.black;
}
