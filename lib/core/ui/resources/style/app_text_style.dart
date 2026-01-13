import 'package:flutter/material.dart' show TextTheme;
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

abstract class AppTextStyle {
  const AppTextStyle._();

  /// Base heights from Figma design
  static const double _compactHeight = 1.33;
  static const double _tightHeight = 1.0;
  static const double _labelHeight = 1.43;
  static const double _displayHeight = 1.40;
  static const double _bodyHeight = 1.75;

  static TextStyle _baseStyle({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    String? fontFamilyOverride,
    double letterSpacing = 0.0,
  }) {
    return TextStyle(
      fontFamily: fontFamilyOverride ?? fontFamily(),
      fontSize: fontSize,
      height: height,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );
  }

  // Display styles (from Figma - largest titles)
  static TextStyle get displayLarge => _baseStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: _compactHeight,
    letterSpacing: -0.60,
  );

  static TextStyle get displayMedium => _baseStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: _displayHeight,
    letterSpacing: -0.60,
  );

  static TextStyle get displaySmall => _baseStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: _tightHeight,
    letterSpacing: -0.45,
  );

  // Headline styles (for section headers)
  static TextStyle get headlineLarge => _baseStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: _tightHeight,
    letterSpacing: -0.45,
  );

  static TextStyle get headlineMedium => _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: _tightHeight,
  );

  static TextStyle get headlineSmall => _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: _labelHeight,
  );

  // Title styles (for card titles, dialog titles)
  static TextStyle get titleLarge => _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: _tightHeight,
  );

  static TextStyle get titleMedium => _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: _labelHeight,
  );

  static TextStyle get titleSmall => _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: _compactHeight,
  );

  // Body styles (for paragraphs of text)
  static TextStyle get bodyLarge => _baseStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: _bodyHeight,
  );

  static TextStyle get bodyMedium => _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: _labelHeight,
  );

  static TextStyle get bodySmall => _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: _compactHeight,
  );

  // Label styles (for UI elements like buttons, tabs)
  static TextStyle get labelLarge => _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: _labelHeight,
  );

  static TextStyle get labelMedium => _baseStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: _compactHeight,
  );

  static TextStyle get labelSmall => _baseStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: _compactHeight,
  );

  static TextTheme get textTheme => TextTheme(
    // Display
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    // Headline
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    // Title
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    // Body
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    // Label
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}

/// Custom Text Styles Extension based on Figma design system
extension CustomTextStylesExtension on BuildContext {
  // ============== Display Styles ==============

  /// Display Large - Hero titles (24px, w600, h1.33, ls-0.60)
  TextStyle get displayLargeTS => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.33,
    letterSpacing: -0.60,
  );

  /// Display Medium - Main page titles (20px, w600, h1.40, ls-0.60)
  TextStyle get displayMediumTS => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.40,
    letterSpacing: -0.60,
  );

  /// Display Small - Section headers (18px, w600, h1.0, ls-0.45)
  TextStyle get displaySmallTS => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.0,
    letterSpacing: -0.45,
  );

  // ============== Headline Styles ==============

  /// Headline Large - Major section titles (18px, w600, h1.0, ls-0.45)
  TextStyle get headlineLargeTS => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.0,
    letterSpacing: -0.45,
  );

  /// Headline Medium - Card headers (16px, w600, h1.0)
  TextStyle get headlineMediumTS => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.0,
  );

  /// Headline Small - Sub-headers (14px, w600, h1.43)
  TextStyle get headlineSmallTS => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.43,
  );

  // ============== Title Styles ==============

  /// Title Large - Card titles (16px, w600, h1.0)
  TextStyle get titleLargeTS => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.0,
  );

  /// Title Medium - List item titles (14px, w600, h1.43)
  TextStyle get titleMediumTS => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.43,
  );

  /// Title Small - Small titles (12px, w600, h1.33)
  TextStyle get titleSmallTS => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.33,
  );

  // ============== Body Styles ==============

  /// Body Large - Main content (16px, w400, h1.75)
  TextStyle get bodyLargeTS => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.75,
  );

  /// Body Medium - Regular text (14px, w400, h1.43)
  TextStyle get bodyMediumTS => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.43,
  );

  /// Body Small - Small text (12px, w400, h1.33)
  TextStyle get bodySmallTS => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.33,
  );

  // ============== Label Styles ==============

  /// Label Large - Button text (14px, w600, h1.43)
  TextStyle get labelLargeTS => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.43,
  );

  /// Label Medium - Tab text, chips (12px, w600, h1.33)
  TextStyle get labelMediumTS => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.33,
  );

  /// Label Small - Small labels (11px, w500, h1.33)
  TextStyle get labelSmallTS => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.33,
  );

  // ============== Specialized Styles ==============

  /// Sensor Value - Large sensor readings (24px, w600, h1.33, ls-0.60)
  TextStyle get sensorValueTS => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    color: colors.onSurface,
    height: 1.33,
    letterSpacing: -0.60,
  );

  /// Sensor Label - Sensor metric labels (12px, w400, h1.33)
  TextStyle get sensorLabelTS => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: this),
    color: colors.subtitleTextColor,
    height: 1.33,
  );

  /// Badge Text - Status badge text (12px, w600, h1.33)
  TextStyle get badgeTS => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: this),
    height: 1.33,
  );

  /// Hint Text - Input hints (14px, w400, h1.43)
  TextStyle get hintTS => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: this),
    color: colors.subtitleTextColor,
    height: 1.2,
  );

  /// Caption - Smallest text (11px, w400, h1.33)
  TextStyle get captionTS => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: this),
    color: colors.subtitleTextColor,
    height: 1.33,
  );
}
