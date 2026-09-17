part of '../../../ui.dart';

class CustomResponsiveBuilder extends StatefulWidget {
  final ResponsiveBuilder mobileBuilder;
  final ResponsiveBuilder tabletBuilder;
  final ResponsiveBuilder desktopBuilder;
  final double mobileBreakpoint;
  final double tabletBreakpoint;
  final Duration animationDuration;
  final Curve animationCurve;
  final EdgeInsetsGeometry? padding;
  final bool applySafeArea;
  final bool useAnimation;

  const CustomResponsiveBuilder({
    super.key,
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    this.mobileBreakpoint = ResponsiveConfig.mobileBreakpoint,
    this.tabletBreakpoint = ResponsiveConfig.tabletBreakpoint,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.easeInOutCubic,
    this.padding,
    this.applySafeArea = false,
    this.useAnimation = false,
  });

  @override
  State<CustomResponsiveBuilder> createState() =>
      _CustomResponsiveBuilderState();
}

class _CustomResponsiveBuilderState extends State<CustomResponsiveBuilder>
    with WidgetsBindingObserver {
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (kIsWeb) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 200), () {
        if (mounted) setState(() {});
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() {});
      });
    }
  }

  DeviceInfo _getDeviceInfo(BuildContext context) {
    return DeviceInfo(
      type: context.deviceType(
        mobileBreakpoint: widget.mobileBreakpoint,
        tabletBreakpoint: widget.tabletBreakpoint,
      ),
      orientation: context.isAppLandscape
          ? OrientationType.landscape
          : OrientationType.portrait,
      width: context.screenWidth,
      height: context.screenHeight,
      isDarkTheme: Theme.of(context).brightness == Brightness.dark,
    );
  }

  ResponsiveBuilder _getBuilder(AppDeviceType deviceType) =>
      switch (deviceType) {
        AppDeviceType.desktop => widget.desktopBuilder,
        AppDeviceType.tablet => widget.tabletBuilder,
        AppDeviceType.mobile => widget.mobileBuilder,
      };

  @override
  Widget build(BuildContext context) {
    final deviceInfo = _getDeviceInfo(context);
    final uniqueKey = ValueKey(
      '${deviceInfo.type.name}_${deviceInfo.orientation.name}_${deviceInfo.isDarkTheme}',
    );

    Widget content = _getBuilder(deviceInfo.type)(context, deviceInfo);
    if (widget.padding != null) {
      content = Padding(padding: widget.padding!, child: content);
    }
    if (widget.applySafeArea) {
      content = SafeArea(child: content);
    }

    return KeyedSubtree(key: uniqueKey, child: content);
  }
}
