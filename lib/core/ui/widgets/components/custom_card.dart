part of '../../ui.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool isChild;
  final ShapeBorder? shape;
  final double? elevation;
  final EdgeInsetsGeometry? innerCardShadowMargin;
  final double? width;
  final double? height;
  final BorderRadius? shadowBorderRadius;
  final bool? shouldShowCustomShadow;
  final BorderRadius? borderRadius;
  final bool enableHover;

  const CustomCard({
    this.padding,
    required this.child,
    this.margin,
    this.color,
    this.shape,
    this.elevation,
    this.innerCardShadowMargin,
    this.width,
    this.height,
    this.shadowBorderRadius,
    this.shouldShowCustomShadow = false,
    this.borderRadius,
    this.isChild = false,
    this.enableHover = false,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = widget.color ??
        (isDark
            ? widget.isChild
                ? context.colors.surfaceContainerHighest
                : context.colors.screenCardSurface
            : Colors.white);

    final finalColor = ((widget.enableHover && _isHovered) && widget.color == null)
        ? Color.alphaBlend(
            context.colors.primary.withValues(alpha: 0.02),
            baseColor,
          )
        : baseColor;

    final baseElevation = widget.elevation ?? (isDark ? 4.0 : 0.0);
    final finalElevation =
        (widget.enableHover && _isHovered) ? baseElevation + 2.0 : baseElevation;

    final card = OptimizedCard(
      width: widget.width,
      height: widget.height,
      margin: widget.margin ??
          (isDark
              ? context.paddingSymmetric(horizontal: 8, vertical: 4)
              : context.paddingSymmetric(horizontal: 6, vertical: 4)),
      shouldShowCustomShadow:
          widget.shouldShowCustomShadow ?? !isDark,
      elevation: finalElevation,
      color: finalColor,
      innerCardShadowMargin: widget.innerCardShadowMargin,
      shadowBorderRadius: widget.shadowBorderRadius,
      shape: widget.shape ??
          RoundedRectangleBorder(
            borderRadius:
                widget.borderRadius ?? BorderRadius.circular(8.r),
            side: isDark && widget.color == null && !widget.isChild
                ? BorderSide(color: context.colors.cardBorderColor)
                : BorderSide.none,
          ),
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
      child: Padding(
        padding: widget.padding ??
            context.paddingSymmetric(horizontal: 8.0, vertical: 8.0),
        child: widget.child,
      ),
    );

    if (!widget.enableHover) {
      return card;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: card,
    );
  }
}
