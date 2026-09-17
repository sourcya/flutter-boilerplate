part of '../../ui.dart';

/// Text action button (from Nasni core).
class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isOutlined;
  final bool isLoading;
  final Color borderColor;
  final Widget? icon;
  final Widget? trailingIcon;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final List<BoxShadow>? shadows;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;
  final Color? disabledBackgroundColor;
  final double iconSpace;
  final bool isIconPositionLeft;
  final bool visualOnly;

  const ActionButton({
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.isOutlined = false,
    this.borderColor = AppColors.transparent,
    this.isLoading = false,
    this.icon,
    this.trailingIcon,
    this.padding,
    this.constraints,
    this.textStyle,
    this.borderRadius,
    this.borderWidth,
    this.shadows,
    this.width,
    this.height,
    this.alignment,
    this.gradient,
    this.disabledBackgroundColor,
    this.iconSpace = 8.0,
    this.isIconPositionLeft = false,
    this.visualOnly = false,
  });

  const ActionButton.outlined({
    this.title = '',
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor = AppColors.transparent,
    this.isLoading = false,
    this.icon,
    this.trailingIcon,
    this.padding,
    this.constraints,
    this.textStyle,
    this.borderRadius,
    this.borderWidth,
    this.shadows,
    this.width,
    this.height,
    this.alignment,
    this.gradient,
    this.disabledBackgroundColor,
    this.iconSpace = 8.0,
    this.isIconPositionLeft = false,
    this.visualOnly = false,
  }) : isOutlined = true;

  const ActionButton.primary({
    this.title = '',
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.trailingIcon,
    this.padding,
    this.constraints,
    this.textStyle,
    this.borderRadius,
    this.borderWidth,
    this.shadows,
    this.width,
    this.height,
    this.alignment,
    this.gradient,
    this.disabledBackgroundColor,
    this.iconSpace = 8.0,
    this.isIconPositionLeft = false,
    this.visualOnly = false,
  }) : borderColor = AppColors.transparent,
       isOutlined = false;

  @override
  Widget build(BuildContext context) {
    final buttonPadding = padding ?? context.paddingSymmetric(horizontal: 14.0, vertical: 8);
    final spinnerWidget = SizedBox(
      width: 20.0.r,
      height: 20.0.r,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2.0.r,
        valueColor: AlwaysStoppedAnimation(
          foregroundColor ?? context.colors.surface,
        ),
      ),
    ).animate().fade();

    final defaultTextStyle = Theme.of(context).textTheme.bodyMedium;
    final titleWidget = title.isNotEmpty
        ? CustomText(
            title,
            translationContext: context,
            textStyle: textStyle ?? defaultTextStyle,
            textAlign: TextAlign.center,
          )
        : null;

    final effectiveConstraints =
        constraints ??
        BoxConstraints.tightFor(
          height: height ?? 40.0.r,
          width: width,
        );

    final isDisabled = onPressed == null && !isLoading;
    final effectiveBgColor = isDisabled
        ? (disabledBackgroundColor ?? context.colors.onSurface.withValues(alpha: 0.12))
        : (backgroundColor ?? context.colors.primary);

    final buttonContent = isLoading
        ? spinnerWidget
        : FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: isIconPositionLeft
                  ? [
                      if (icon != null) icon ?? const SizedBox.shrink(),
                      if (icon != null && titleWidget != null) iconSpace.wBox,
                      if (titleWidget != null) titleWidget,
                      if (trailingIcon != null && titleWidget != null) iconSpace.wBox,
                      if (trailingIcon != null) trailingIcon ?? const SizedBox.shrink(),
                    ]
                  : [
                      if (titleWidget != null) titleWidget,
                      if (icon != null && titleWidget != null) iconSpace.wBox,
                      if (icon != null) icon ?? const SizedBox.shrink(),
                      if (trailingIcon != null && (titleWidget != null || icon != null))
                        iconSpace.wBox,
                      if (trailingIcon != null) trailingIcon ?? const SizedBox.shrink(),
                    ],
            ),
          );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: borderRadius ?? 6.0.radius,
      side: isOutlined
          ? BorderSide(
              color: borderColor,
              width: borderWidth ?? 1.0,
            )
          : BorderSide.none,
    );

    if (visualOnly) {
      return AnimatedContainer(
        constraints: effectiveConstraints,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius ?? 30.radius,
          boxShadow: shadows,
        ),
        child: Material(
          color: gradient != null
              ? AppColors.transparent
              : (backgroundColor ?? context.colors.primary),
          shape: buttonShape,
          child: Padding(
            padding: buttonPadding,
            child: Align(
              alignment: alignment ?? Alignment.center,
              child: DefaultTextStyle.merge(
                style: TextStyle(color: foregroundColor ?? context.colors.surface),
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: foregroundColor ?? context.colors.surface,
                  ),
                  child: buttonContent,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final useDenseButton =
        (height != null && (height ?? 0) < 40.0.r) ||
        (constraints != null &&
            (constraints?.hasBoundedHeight == true) &&
            (constraints?.maxHeight ?? 0) < 40.0.r);

    final buttonWidget = AnimatedContainer(
      constraints: effectiveConstraints,
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius ?? 30.radius,
        boxShadow: shadows,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          alignment: alignment ?? AlignmentDirectional.center,
          backgroundColor: gradient != null ? AppColors.transparent : effectiveBgColor,
          foregroundColor: foregroundColor ?? context.colors.surface,
          padding: buttonPadding,
          elevation: 0,
          shadowColor: const Color(0x0C000000),
          shape: buttonShape,
          minimumSize: useDenseButton ? Size.zero : null,
          tapTargetSize: useDenseButton ? MaterialTapTargetSize.shrinkWrap : null,
          visualDensity: useDenseButton ? VisualDensity.compact : null,
        ),
        child: buttonContent,
      ),
    );

    return buttonWidget;
  }
}
