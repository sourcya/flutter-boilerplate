import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/widgets/responsive/responsive_navigation_config.dart';
import 'package:playx/playx.dart' hide DeviceType;

class CustomResponsiveBuilder extends StatefulWidget {
  /// Builder for mobile devices (width <= 600)
  final ResponsiveBuilder mobileBuilder;

  /// Builder for tablet devices (600 < width <= 840)
  final ResponsiveBuilder tabletBuilder;

  /// Builder for desktop devices (width > 1200)
  final ResponsiveBuilder desktopBuilder;

  /// Custom breakpoints for device detection
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  /// Animation duration for transitions
  final Duration animationDuration;

  /// Animation curve for transitions
  final Curve animationCurve;

  /// Whether to enable debug logging
  final bool enableDebugLog;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Whether to apply safe area padding
  final bool applySafeArea;

  /// Custom padding to apply
  final EdgeInsetsGeometry? padding;

  const CustomResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    this.mobileBreakpoint = ResponsiveConfig.mobileBreakpoint,
    this.tabletBreakpoint = ResponsiveConfig.tabletBreakpoint,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.easeInOutCubic,
    this.enableDebugLog = kDebugMode,
    this.semanticLabel,
    this.applySafeArea = true,
    this.padding,
  });

  @override
  State<CustomResponsiveBuilder> createState() =>
      _CustomResponsiveBuilderState();
}

class _CustomResponsiveBuilderState extends State<CustomResponsiveBuilder>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  DeviceInfo? _currentDeviceInfo;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAnimations();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ),
        );

    _animationController.forward();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Trigger rebuild when device metrics change (orientation, etc.)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
      // final v = await ResponsiveUtils.getDeviceTypeWithPlugin();
      // "Device Type WithPlugin : $v".printInfo();
    });
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Trigger rebuild when system theme changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  DeviceInfo _getDeviceInfo(BuildContext context) {
    final width = context.width;
    final height = context.screenHeight;

    final deviceType = context.deviceType(
      mobileBreakpoint: widget.mobileBreakpoint,
      tabletBreakpoint: widget.tabletBreakpoint,
    );
    final orientation = context.isLandscape
        ? OrientationType.landscape
        : OrientationType.portrait;

    return DeviceInfo(
      type: deviceType,
      orientation: orientation,
      width: width,
      height: height,
      isDarkTheme: context.isDarkMode,
    );
  }

  ResponsiveBuilder _getBuilder(DeviceType deviceType) => switch (deviceType) {
    DeviceType.desktop => widget.desktopBuilder,
    DeviceType.tablet => widget.tabletBuilder,
    DeviceType.mobile => widget.mobileBuilder,
  };

  void _logDeviceChange(DeviceInfo newInfo) {
    if (widget.enableDebugLog) {
      '🔄 ResponsiveFormBuilder: Device changed to $newInfo'.printInfo();
      if (_currentDeviceInfo != null) {
        final oldInfo = _currentDeviceInfo!;
        if (oldInfo.type != newInfo.type) {
          '📱 Device type: ${oldInfo.type.name} → ${newInfo.type.name}'
              .printInfo();
        }
        if (oldInfo.orientation != newInfo.orientation) {
          '🔄 Orientation: ${oldInfo.orientation.name} → ${newInfo.orientation.name}'
              .printInfo();
        }
        if (oldInfo.isDarkTheme != newInfo.isDarkTheme) {
          '🌙 Theme: ${oldInfo.isDarkTheme ? 'dark' : 'light'} → ${newInfo.isDarkTheme ? 'dark' : 'light'}'
              .printInfo();
        }
      }
    }
  }

  Widget _buildContent(BuildContext context, DeviceInfo deviceInfo) {
    final builder = _getBuilder(deviceInfo.type);

    Widget content = builder(context, deviceInfo);

    // Apply padding if specified
    if (widget.padding != null) {
      content = Padding(padding: widget.padding!, child: content);
    }

    // Apply safe area if enabled
    if (widget.applySafeArea) {
      content = SafeArea(child: content);
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = _getDeviceInfo(context);
    "Device Type : $deviceInfo".printInfo();

    // Check if device info has changed
    if (_currentDeviceInfo != deviceInfo) {
      _logDeviceChange(deviceInfo);
      _currentDeviceInfo = deviceInfo;

      // Restart animation on device change
      _animationController.reset();
      _animationController.forward();
    }

    // Create unique key based on device info for proper widget rebuilding
    final uniqueKey = ValueKey(
      '${deviceInfo.type.name}_${deviceInfo.orientation.name}_${deviceInfo.isDarkTheme}',
    );

    Widget child = KeyedSubtree(
      key: uniqueKey,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildContent(context, deviceInfo),
      ),
    );

    // Add semantic label for accessibility
    if (widget.semanticLabel != null) {
      child = Semantics(label: widget.semanticLabel, child: child);
    }

    return AnimatedSwitcher(
      duration: widget.animationDuration,
      switchInCurve: widget.animationCurve,
      switchOutCurve: widget.animationCurve,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: widget.animationCurve,
                  ),
                ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
