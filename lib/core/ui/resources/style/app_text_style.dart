part of '../../ui.dart';

extension CustomTextStylesExtension on BuildContext {
  TextStyle get displayLargeTS => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.33,
        letterSpacing: -0.60,
      );

  TextStyle get displayMediumTS => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.40,
        letterSpacing: -0.60,
      );

  TextStyle get headlineMediumTS => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.0,
      );

  TextStyle get headlineSmallTS => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.43,
      );

  TextStyle get bodyLargeTS => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.75,
      );

  TextStyle get bodyMediumTS => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.43,
      );

  TextStyle get labelLargeTS => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.43,
      );

  TextStyle get labelMediumTS => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.43,
      );

  TextStyle get bodySmallTS => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.43,
      );

  TextStyle get titleMediumTS => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.5,
      );

  TextStyle get titleLargeTS => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily(context: this),
        color: colors.onSurface,
        height: 1.0,
      );
}
