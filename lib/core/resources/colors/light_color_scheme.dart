import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_color_scheme.dart';

class LightColorScheme extends AppColors {
  @override
  Color get containerBackgroundColor => XColorScheme.white;

  @override
  Color get background => XColorScheme.white;

  @override
  Color get error => XColorScheme.red;

  @override
  Color get onBackground => XColorScheme.black;

  @override
  Color get onError => XColorScheme.white;

  @override
  Color get onPrimary => XColorScheme.white;

  @override
  Color get onSecondary => XColorScheme.white;

  @override
  Color get onSurface => XColorScheme.black;

  @override
  Color get primary => Colors.black;

  @override
  Color get secondary => XColorScheme.black;

  @override
  Color get surface => XColorScheme.white;

  @override
  Color get appBar => XColorScheme.white;

  @override
  Color? get chipBackgroundColor => Colors.grey;

  @override
  Color? get subtitleTextColor => Colors.grey[600];

  @override
  Color? get buttonBackgroundColor => primary;
  @override
  Color? get onButtonColor => XColorScheme.white;

  @override
  Color? get bottomBarUnselectedColor => const Color(0XFFAFAFAF);

  @override
  Color? get bottomBarShadowColor => Colors.grey[300];

  @override
  Color get onAppBar => XColorScheme.black;


  @override
  Color? get onChipBackgroundColor => Colors.white;


}
