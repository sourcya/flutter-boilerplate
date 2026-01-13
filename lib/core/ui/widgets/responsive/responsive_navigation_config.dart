import 'dart:io';
import 'dart:math' as math show min;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class ResponsiveConfig {
  const ResponsiveConfig._instance();
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 840.0;
  static const double desktopBreakpoint = 1024.0;

  static double railWidth = PlayxNavigation.navigationContext?.railWidth ?? 80.0;
  static double extendedRailWidth = PlayxNavigation.navigationContext?.extendedRailWidth ?? 256.0;
  static const double drawerWidth = 320.0;

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOutCubic;
}

enum DeviceType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
  bool get isDesktop => this == DeviceType.desktop;

  T valueWhen<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return switch (this) {
      DeviceType.mobile => mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.desktop => desktop ?? tablet ?? mobile,
    };
  }
}

enum OrientationType {
  portrait,
  landscape;

  bool get isLandScape => this == OrientationType.landscape;
  bool get isPortrait => this == OrientationType.portrait;
}

class DeviceInfo {
  final DeviceType type;
  final OrientationType orientation;
  final double width;
  final double height;
  final bool isDarkTheme;

  const DeviceInfo({
    required this.type,
    required this.orientation,
    required this.width,
    required this.height,
    required this.isDarkTheme,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInfo &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          orientation == other.orientation &&
          isDarkTheme == other.isDarkTheme;

  @override
  int get hashCode => type.hashCode ^ orientation.hashCode ^ isDarkTheme.hashCode;

  @override
  String toString() => 'DeviceInfo(type: $type, orientation: $orientation, isDark: $isDarkTheme)';
}

typedef ResponsiveBuilder =
    Widget Function(
      BuildContext context,
      DeviceInfo deviceInfo,
    );

extension ResponsiveExtension on BuildContext {
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get pixelRatio => mediaQuery.devicePixelRatio;

  double get extendedRailWidth => screenWidth * .25;
  double get railWidth => 80.0;

  TargetPlatform get platform => Theme.of(this).platform;
  bool get isIOS => platform == TargetPlatform.iOS;
  bool get isAndroid => platform == TargetPlatform.android;
  bool get isWeb => kIsWeb;
  DeviceInfo get deviceInfo => DeviceInfo(
    type: deviceType(),
    orientation: orientation == Orientation.landscape
        ? OrientationType.landscape
        : OrientationType.portrait,
    width: screenWidth,
    height: screenHeight,
    isDarkTheme: Theme.of(this).brightness == Brightness.dark,
  );
  DeviceType deviceType({
    double mobileBreakpoint = ResponsiveConfig.mobileBreakpoint,
    double tabletBreakpoint = ResponsiveConfig.tabletBreakpoint,
  }) {
    if (kIsWeb) {
      return deviceTypeBasedOnScreenWidth(
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
      );
    }

    try {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        return DeviceType.desktop;
      }

      if (Platform.isAndroid || Platform.isIOS) {
        final shortestSide = mediaQuery.size.shortestSide;
        final aspectRatio = mediaQuery.size.longestSide / shortestSide;
        // final devicePixelRatio = mediaQuery.devicePixelRatio;
        return switch (shortestSide >= tabletBreakpoint && aspectRatio < 1.8) {
          true => DeviceType.tablet,
          _ => DeviceType.mobile,
        };
      }
    } catch (_) {
      return deviceTypeBasedOnScreenWidth(
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
      );
    }

    return deviceTypeBasedOnScreenWidth(
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    );
  }

  /// Device type detection based on screen width
  DeviceType deviceTypeBasedOnScreenWidth({
    double mobileBreakpoint = ResponsiveConfig.mobileBreakpoint,
    double tabletBreakpoint = ResponsiveConfig.tabletBreakpoint,
  }) => switch (width < mobileBreakpoint) {
    true => DeviceType.mobile,
    _ => switch (width < tabletBreakpoint) {
      true => DeviceType.tablet,
      _ => DeviceType.desktop,
    },
  };
  bool get isTablet => deviceType().isTablet;
  bool get isMobile => deviceType().isMobile;
  bool get isDesktop => deviceType().isDesktop;
  bool get isTabletSW => deviceTypeBasedOnScreenWidth().isTablet;
  bool get isMobileSW => deviceTypeBasedOnScreenWidth().isMobile;
  bool get isDesktopSW => deviceTypeBasedOnScreenWidth().isDesktop;

  T valueWhen<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = deviceTypeBasedOnScreenWidth();
    return switch (deviceType) {
      DeviceType.mobile => mobile,
      DeviceType.tablet => tablet ?? mobile,
      DeviceType.desktop => desktop ?? tablet ?? mobile,
    };
  }

  EdgeInsets getResponsivePadding() {
    return valueWhen(
      mobile: EdgeInsets.all(16.r),
      tablet: EdgeInsets.all(24.r),
      desktop: EdgeInsets.all(32.r),
    );
  }

  EdgeInsets getResponsiveMargin() {
    return valueWhen(
      mobile: EdgeInsets.all(12.r),
      tablet: EdgeInsets.all(16.r),
      desktop: EdgeInsets.all(24.r),
    );
  }

  EdgeInsets getDialogPadding() {
    return valueWhen(
      mobile: EdgeInsets.all(16.r),
      tablet: EdgeInsets.all(40.r),
      desktop: EdgeInsets.all(80.r),
    );
  }

  /*
double _getRadius(DeviceType deviceType, bool isIOS) {
    final baseRadius = switch (deviceType) {
      DeviceType.mobile => 12.0,
      DeviceType.tablet => 14.0,
      DeviceType.desktop => 16.0,
    };
    // Adaptive: Larger radius on iOS for smoother corners
    return (isIOS ? baseRadius + 4.0 : baseRadius).r;
  } */
  EdgeInsets getDefaultPadding([bool isChild = false]) {
    final basePadding = switch (isChild) {
      true => valueWhen(mobile: 8.0, tablet: 10.0, desktop: 12.0),
      false => valueWhen(mobile: 12.0, tablet: 14.0, desktop: 16.0),
    };

    final adjustedPadding = isAndroid ? basePadding * 0.9 : basePadding;
    return EdgeInsets.all(adjustedPadding);
  }

  EdgeInsets getDefaultMargin([bool isChild = false]) {
    if (isChild) {
      return EdgeInsets.symmetric(
        horizontal: valueWhen(mobile: 4.0.r, tablet: 6.0.r, desktop: 8.0.r),
        vertical: valueWhen(mobile: 3.0.r, tablet: 4.0.r, desktop: 5.0.r),
      );
    }

    return EdgeInsets.symmetric(
      horizontal: valueWhen(mobile: 8.0.r, tablet: 10.0.r, desktop: 12.0.r),
      vertical: valueWhen(mobile: 6.0.r, tablet: 8.0.r, desktop: 10.0.r),
    );
  }

  double getDefaultRadius() {
    final baseRadius = valueWhen(mobile: 12.0, tablet: 14.0, desktop: 16.0);

    final adjustedPadding = (isIOS ? baseRadius + 4.0 : baseRadius).r;
    return adjustedPadding;
  }

  double getDefaultGab() {
    // if web Gab is 24
    final baseGab = valueWhen(mobile: 12.0, tablet: 18.0, desktop: 24.0);

    return baseGab;
  }

  double getResponsiveWidth({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    return valueWhen(
      mobile: mobile ?? screenWidth,
      tablet: tablet ?? math.min(ResponsiveConfig.tabletBreakpoint, screenWidth * 0.9),
      desktop: desktop ?? math.min(ResponsiveConfig.desktopBreakpoint, screenWidth * 0.8),
    );
  }
}

extension CardStyleExtension on BuildContext {
  /// The exact two-layer shadow from the Figma card.
  /// Light → Color(0x19000000)  (alpha ≈ 10%)
  /// Dark  → Color(0x19000000)  (same alpha, looks softer on dark bg)
  List<BoxShadow> get cardBoxShadow {
    final shadowColor = colors.shadow; // 0x19000000 in both themes
    return [
      BoxShadow(
        color: shadowColor,
        blurRadius: 2,
        offset: const Offset(0, 1),
        spreadRadius: -1,
      ),
      BoxShadow(
        color: shadowColor,
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ];
  }

  bool get isWebLayout => (isTablet || isDesktop) && isLandscape;
}
