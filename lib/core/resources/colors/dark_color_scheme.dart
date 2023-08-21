
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import 'app_color_scheme.dart';

class DarkColorScheme extends AppColors {
  @override
  Color get background => XColorScheme.black;

  @override
  Color get error => XColorScheme.redLight;

  @override
  Color get onBackground => XColorScheme.white;

  @override
  Color get onError => XColorScheme.black;

  @override
  Color get onPrimary => XColorScheme.black;

  @override
  Color get onSecondary => XColorScheme.black;

  @override
  Color get onSurface => XColorScheme.white;

  @override
  Color get primary => XColorScheme.white;

  @override
  Color get secondary => XColorScheme.white;

  @override
  Color get surface => XColorScheme.black;

  @override
  Color get containerBackgroundColor => XColorScheme.black;

  @override
  Color get appBar => XColorScheme.black;

  @override
  Color? get subtitleTextColor => Colors.grey[400];

  @override
  Color? get chipBackgroundColor => Colors.grey[700];

  @override
  Color? get buttonBackgroundColor => XColorScheme.white;

  @override
  Color? get bottomBarUnselectedColor => Colors.grey[600];

  @override
  Color? get onButtonColor => XColorScheme.black;

  @override
  Color? get bottomBarShadowColor => Colors.transparent;

  @override
  Color get onAppBar => XColorScheme.white;
}
