part of '../../ui.dart';

class CustomCard extends StatelessWidget {
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
    this.shouldShowCustomShadow,
    this.borderRadius,
    this.isChild = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = AppUtils.isDarkMode();
    return OptimizedCard(
      width: width,
      height: height,
      margin: margin ??
          (isDarkMode
              ? EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.h)
              : EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.h)),
      shouldShowCustomShadow: shouldShowCustomShadow ?? !isDarkMode,
      elevation: elevation ?? (isDarkMode ? 4 : 0),
      color: color ??
          (isDarkMode
              ? isChild
                  ? context.colors.surfaceContainerHighest
                  : context.colors.surfaceContainerHigh
              : context.colors.surface),
      innerCardShadowMargin: innerCardShadowMargin,
      shadowBorderRadius: shadowBorderRadius,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          ),
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 8.0.h),
        child: child,
      ),
    );
  }
}
