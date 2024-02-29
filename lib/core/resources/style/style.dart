import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

abstract class Style {
  Style._();

  static BorderRadius featureChipBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius fieldBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius dialogBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius buttonBorderRadius = BorderRadius.circular(30.r);

  static RoundedRectangleBorder featureChipRoundedRectangleBorder =
      RoundedRectangleBorder(
    borderRadius: featureChipBorderRadius,
  );

  static RoundedRectangleBorder fieldRoundedRectangleBorder =
      RoundedRectangleBorder(
    borderRadius: fieldBorderRadius,
  );

  static RoundedRectangleBorder dialogRoundedRectangleBorder =
      RoundedRectangleBorder(
    borderRadius: dialogBorderRadius,
  );

  static RoundedRectangleBorder buttonRoundedBorder =
      RoundedRectangleBorder(borderRadius: buttonBorderRadius);

  //padding
  static EdgeInsetsGeometry defaultPadding =
      EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h);

  static EdgeInsetsGeometry mediumPadding =
      EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h);
}
