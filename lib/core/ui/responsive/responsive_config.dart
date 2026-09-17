part of '../ui.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  DeviceInfo deviceInfo,
);

class ResponsiveConfig {
  const ResponsiveConfig._instance();

  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1080.0;
  static const double desktopBreakpoint = 1080.0;

  /// Web / desktop layout switch: width >= this value uses the landscape shell.
  static const double landscapeBreakpoint = 1080.0;

  static const Size mobileDesignSize = Size(375.0, 812.0);
  static const Size tabletDesignSize = Size(768.0, 1024.0);
  static const Size webDesignSize = Size(1440.0, 960.0);

  static const double maxPortraitWidth = 600.0;
  static const double drawerWidth = 310.0;
  static const double drawerExpandedRailWidth = 237.0;
  static const double railWidth = 64.0;
  static const double extendedRailWidth = drawerExpandedRailWidth;
  static const double nativeLandscapeThreshold = 840.0;

  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOutCubic;
}

enum AppDeviceType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == AppDeviceType.mobile;
  bool get isTablet => this == AppDeviceType.tablet;
  bool get isDesktop => this == AppDeviceType.desktop;

  T valueWhen<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return switch (this) {
      AppDeviceType.mobile => mobile,
      AppDeviceType.tablet => tablet ?? mobile,
      AppDeviceType.desktop => desktop ?? tablet ?? mobile,
    };
  }
}

enum OrientationType {
  portrait,
  landscape;

  bool get isLandscape => this == OrientationType.landscape;
  bool get isPortrait => this == OrientationType.portrait;
}

class DeviceInfo {
  final AppDeviceType type;
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
}

extension ResponsiveExtension on BuildContext {
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;

  bool get isWeb => kIsWeb;

  /// Single source of truth for layout decisions (portrait shell vs landscape shell).
  bool get isAppLandscape {
    final isDesktopPlatform = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;

    if (kIsWeb || isDesktopPlatform) {
      return screenWidth >= ResponsiveConfig.landscapeBreakpoint;
    }

    if (!isLandscape) {
      return false;
    }

    const nativeLandscapeThreshold = 840.0;
    return screenWidth >= nativeLandscapeThreshold;
  }

  bool get isWebLayout => isAppLandscape;

  bool get isAppPortrait => !isAppLandscape;

  Size get currentDesignSize {
    if (isAppLandscape) {
      return ResponsiveConfig.webDesignSize;
    }
    if (screenWidth >= 600.0) {
      return ResponsiveConfig.tabletDesignSize;
    }
    return ResponsiveConfig.mobileDesignSize;
  }

  AppDeviceType deviceType({
    double mobileBreakpoint = ResponsiveConfig.mobileBreakpoint,
    double tabletBreakpoint = ResponsiveConfig.tabletBreakpoint,
  }) {
    return deviceTypeBasedOnScreenWidth(
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    );
  }

  AppDeviceType deviceTypeBasedOnScreenWidth({
    double mobileBreakpoint = ResponsiveConfig.mobileBreakpoint,
    double tabletBreakpoint = ResponsiveConfig.tabletBreakpoint,
  }) {
    final shortestSide = min(screenWidth, screenHeight);
    if (shortestSide < mobileBreakpoint) {
      return AppDeviceType.mobile;
    }
    return screenWidth < tabletBreakpoint
        ? AppDeviceType.tablet
        : AppDeviceType.desktop;
  }

  bool get isTablet => deviceType().isTablet;
  bool get isMobile => deviceType().isMobile;
  bool get isDesktop => deviceType().isDesktop;
  bool get isMobileOrWeb => isMobile || isWeb;

  T valueWhenDevice<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return deviceInfo.type.valueWhen(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  bool get isWideLayout => isAppLandscape;

  DeviceInfo get deviceInfo => DeviceInfo(
        type: deviceType(),
        orientation: isAppLandscape
            ? OrientationType.landscape
            : OrientationType.portrait,
        width: screenWidth,
        height: screenHeight,
        isDarkTheme: Theme.of(this).brightness == Brightness.dark,
      );
}
