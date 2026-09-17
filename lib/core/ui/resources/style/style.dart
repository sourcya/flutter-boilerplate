part of '../../ui.dart';

abstract class Style {
  Style._();

  static BorderRadius featureChipBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius fieldBorderRadius = BorderRadius.circular(12.r);

  static BorderRadius dialogBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius buttonBorderRadius = BorderRadius.circular(30.r);

  static BorderRadius compactButtonBorderRadius = BorderRadius.circular(12.r);

  static BorderRadius cardBorderRadius = BorderRadius.circular(16.r);

  static BorderRadius radius9999 = BorderRadius.circular(9999.r);

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
  static EdgeInsetsGeometry defaultPadding(BuildContext context) =>
      context.paddingSymmetric(horizontal: 8, vertical: 8);

  static EdgeInsetsGeometry mediumPadding(BuildContext context) =>
      context.paddingSymmetric(horizontal: 4, vertical: 4);

  static BorderRadiusGeometry get largeBorderRadius =>
      BorderRadius.circular(24.r);

  static OutlineInputBorder noneBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide.none,
      );

  static List<BoxShadow> shadowSmall(BuildContext context) =>
      AppShadows.subtleShadow(context.colors.cardShadowColor);
}
