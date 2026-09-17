part of '../../ui.dart';

/// A rounded container with an icon, optionally tappable.
/// Reusable for group icon, list leading icon, etc.
class RoundedIconContainer extends StatelessWidget {
  final String iconName;
  final VoidCallback? onTap;
  final double? size;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final String? label;

  const RoundedIconContainer({
    super.key,
    required this.iconName,
    this.onTap,
    this.size,
    this.iconSize,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.color,
    this.borderColor,
    this.margin,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
      child: Align(
        child: Container(
          padding: padding ?? context.paddingAll(6),
          margin: margin,
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            border: Border.all(
              color: borderColor ?? context.colors.primaryContainer,
            ),
          ),
          width: label != null ? null : size,
          height: label != null ? null : size,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.r,
            children: [
              ImageViewer.svgAsset(
                iconName,
                width: iconSize ?? 26.r,
                height: iconSize ?? 26.r,
                color: color ?? context.colors.primary,
              ),
              if (label != null)
                Flexible(
                  child: CustomText(
                    label!,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: color ?? context.colors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
