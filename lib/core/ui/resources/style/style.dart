part of '../../ui.dart';

abstract class Style {
  Style._();

  static final mapButtonBorderRadius = BorderRadius.circular(12.r);

  static final mapButtonShape = RoundedRectangleBorder(
    borderRadius: mapButtonBorderRadius,
  );

  static BorderRadius featureChipBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius fieldBorderRadius = BorderRadius.circular(12.r);
  static BorderRadius cardBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius dialogBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius buttonBorderRadius = BorderRadius.circular(30.r);
  static BorderRadius compactButtonBorderRadius = BorderRadius.circular(12.r);

  static RoundedRectangleBorder featureChipRoundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: featureChipBorderRadius,
  );

  static RoundedRectangleBorder fieldRoundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: fieldBorderRadius,
  );

  static RoundedRectangleBorder dialogRoundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: dialogBorderRadius,
  );

  static RoundedRectangleBorder buttonRoundedBorder = RoundedRectangleBorder(
    borderRadius: buttonBorderRadius,
  );

  //padding
  static EdgeInsetsGeometry defaultPadding = EdgeInsets.symmetric(
    horizontal: 8.r,
    vertical: 8.r,
  );

  static EdgeInsetsGeometry mediumPadding = EdgeInsets.symmetric(
    horizontal: 4.r,
    vertical: 4.r,
  );

  static EdgeInsetsGeometry all8Padding = EdgeInsets.all(8.r);
  static EdgeInsetsGeometry all12Padding = EdgeInsets.all(12.r);
  static EdgeInsetsGeometry all16Padding = EdgeInsets.all(16.r);

  static BorderRadiusGeometry get largeBorderRadius => BorderRadius.circular(24.r);

  static OutlineInputBorder noneBorder(BuildContext context) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide.none,
  );

  static List<BoxShadow> supportButtonStyle(BuildContext context) => [
        BoxShadow(
          color: context.colors.shadow.withValues(alpha: 0.1),
          blurRadius: 3.43,
          offset: const Offset(0, 2.29),
          spreadRadius: -2.29,
        ),
        BoxShadow(
          color: context.colors.shadow.withValues(alpha: 0.1),
          blurRadius: 8.57,
          offset: const Offset(0, 5.71),
          spreadRadius: -1.71,
        ),
      ];
}
