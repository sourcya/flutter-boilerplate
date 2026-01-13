import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/ui/widgets/responsive/responsive_navigation_config.dart'
    show DeviceType, ResponsiveExtension;
import 'package:playx/playx.dart' hide DeviceType;

class CustomResponsiveCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isChild;
  final double? elevation;
  final Color? color;
  final bool enableDefShadow;
  final bool enableHovered;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final Clip? clipBehavior;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final bool selected;

  const CustomResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.enableDefShadow = false,
    this.enableHovered = true,
    this.isChild = false,
    this.elevation,
    this.color,
    this.borderRadius,
    this.onTap,
    this.clipBehavior,
    this.border,
    this.boxShadow,
    this.selected = false,
  });

  @override
  State<CustomResponsiveCard> createState() => _CustomResponsiveCardState();
}

class _CustomResponsiveCardState extends State<CustomResponsiveCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final deviceType = context.deviceType();

    //  colors
    final cardColor = widget.color ?? _getDefaultColor(context, isDark, widget.isChild);

    // Responsive border radius, adaptive for iOS (slightly larger for Apple design language)
    final radius = widget.borderRadius ?? BorderRadius.circular(context.getDefaultRadius());

    // Responsive padding, adaptive for platform (compact on Android mobile)
    final cardPadding = widget.padding ?? context.getDefaultPadding(widget.isChild);

    // Responsive margin
    final cardMargin = widget.margin ?? context.getDefaultMargin(widget.isChild);

    // Shadow color
    final shadowColor = isDark ? const Color(0x89000000) : const Color(0x42000000);

    // Responsive blur and offset based on device type, theme, and hover
    final normalBlur = _getNormalBlur(deviceType, widget.isChild, isDark) * .5;
    final hoveredBlur = normalBlur * 2.0;
    final normalOffset = _getNormalOffset(deviceType, widget.isChild, isDark);
    final hoveredOffset = normalOffset * 2.5;

    // Border color with hover effect
    final borderColor = _isHovered
        ? context.colors.primary.withValues(alpha: 0.3)
        : context.colors.borderColor;

    // Optional: Use widget.elevation if provided to override base blur/offset
    final baseBlur = widget.elevation != null ? widget.elevation! * 4.0 : normalBlur;
    final baseOffset = widget.elevation != null ? widget.elevation! * 2.0 : normalOffset;
    final baseHoveredBlur = widget.elevation != null ? widget.elevation! * 8.0 : hoveredBlur;
    final baseHoveredOffset = widget.elevation != null ? widget.elevation! * 5.0 : hoveredOffset;

    // Constraints for compact layouts on small screens (mobile)
    // BoxConstraints? constraints;
    // constraints = context.valueWhen(
    //   mobile: BoxConstraints(maxWidth: context.width * 0.9),
    //   tablet: BoxConstraints(maxWidth: (context.width * (600 / 1355)).w),
    //   desktop: BoxConstraints(maxWidth: (context.width * (389 / 1355)).w),
    // );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, animChild) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: cardMargin,
              // constraints: constraints,
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: radius,
                boxShadow: [
                  ...?widget.boxShadow,
                  if (widget.enableHovered)
                    if (widget.enableDefShadow || _isHovered)
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: _isHovered ? baseHoveredBlur : baseBlur * .5,
                        offset: Offset(
                          0,
                          _isHovered ? baseHoveredOffset : baseOffset * .5,
                        ),
                      ),
                ],
                border: widget.border ?? Border.all(color: borderColor),
              ),
              child: ClipRRect(
                borderRadius: radius,
                clipBehavior: widget.clipBehavior ?? Clip.antiAlias,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: radius,
                  child: Padding(padding: cardPadding, child: widget.child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getNormalBlur(DeviceType deviceType, bool isChild, bool isDark) {
    if (isChild) {
      return switch (deviceType) {
        DeviceType.mobile => isDark ? 4.0 : 6.0,
        DeviceType.tablet => isDark ? 6.0 : 8.0,
        DeviceType.desktop => isDark ? 8.0 : 10.0,
      };
    }

    return switch (deviceType) {
      DeviceType.mobile => isDark ? 8.0 : 12.0,
      DeviceType.tablet => isDark ? 12.0 : 16.0,
      DeviceType.desktop => isDark ? 16.0 : 20.0,
    };
  }

  double _getNormalOffset(DeviceType deviceType, bool isChild, bool isDark) {
    if (isChild) {
      return switch (deviceType) {
        DeviceType.mobile => isDark ? 2.0 : 3.0,
        DeviceType.tablet => isDark ? 3.0 : 4.0,
        DeviceType.desktop => isDark ? 4.0 : 5.0,
      };
    }

    return switch (deviceType) {
      DeviceType.mobile => isDark ? 4.0 : 6.0,
      DeviceType.tablet => isDark ? 6.0 : 8.0,
      DeviceType.desktop => isDark ? 8.0 : 10.0,
    };
  }

  Color _getDefaultColor(BuildContext context, bool isDark, bool isChild) {
    if (isChild) {
      return isDark ? context.colors.surfaceContainer : context.colors.cardColor;
    }

    return isDark ? context.colors.surfaceContainerHigh : context.colors.cardColor;
  }
}
