part of '../../ui.dart';

class CustomElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? label;
  final String? labelFont;

  final double? fontSize;
  final Color? backgroundColor;
  final Color? color;

  final Color? disabledBackground;
  final Widget? child;
  final BorderRadius? borderRadius;

  final double? width;
  final double? minWidth;
  final IconInfo? icon;
  final double? iconSpace;
  final double? iconSize;
  final bool iconAtStart;

  final bool isCompact;
  final bool isMaxWidth;

  final Gradient? gradient;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final BoxConstraints? constraints;

  const CustomElevatedButton({
    this.margin,
    this.onPressed,
    this.isLoading = false,
    this.padding,
    this.fontSize,
    this.label,
    this.disabledBackground,
    this.child,
    this.borderRadius,
    this.width,
    this.minWidth,
    this.labelFont,
    this.backgroundColor,
    this.icon,
    this.isCompact = false,
    this.color,
    this.isMaxWidth = true,
    this.iconSpace,
    this.iconSize,
    this.gradient,
    this.borderColor,
    this.iconAtStart = true,
    this.fontWeight,
    this.constraints,
  });

  // TODO: add `CustomElevatedButton.filled`

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        borderRadius ?? (isCompact ? Style.compactButtonBorderRadius : Style.buttonBorderRadius);
    final effectivePadding =
        padding ??
        (isCompact
            ? context.paddingSymmetric(horizontal: 8, vertical: 12)
            : context.paddingSymmetric(horizontal: 8, vertical: 16));
    final effectiveButtonPadding =
        padding ??
        (isCompact
            ? context.paddingSymmetric(horizontal: 8, vertical: 12)
            : context.paddingSymmetric(horizontal: 8, vertical: 18));
    final effectiveColor = gradient != null
        ? AppColors.transparent
        : backgroundColor ?? context.colors.primary;
    final effectiveDisabledColor = disabledBackground ?? context.colors.loginDisabledColor;

    return PointerInterceptor(
      child: MouseRegion(
        cursor: onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Container(
          padding: margin ?? context.paddingOnly(start: 14, end: 14, top: 11, bottom: 11),
          width:
              width ??
              (isMaxWidth
                  ? (context.isAppLandscape || context.width >= 1000
                        ? context.width * .4
                        : double.infinity)
                  : null),
          constraints:
              constraints ?? (minWidth != null ? BoxConstraints(minWidth: minWidth!) : null),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: effectiveBorderRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: effectiveBorderRadius,
              border: borderColor != null ? Border.all(color: borderColor!) : null,
            ),
            child: PlatformElevatedButton(
              onPressed: onPressed,
              padding: effectivePadding,
              material: (ctx, _) => MaterialElevatedButtonData(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: effectiveDisabledColor,
                  padding: effectiveButtonPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: effectiveBorderRadius,
                    side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
                  ),
                  backgroundColor: effectiveColor,
                ),
              ),
              color: effectiveColor,
              cupertino: (ctx, _) => CupertinoElevatedButtonData(
                disabledColor: effectiveDisabledColor,
                padding: effectiveButtonPadding,
                borderRadius: effectiveBorderRadius,
              ),
              child: _ElevatedButtonChild(
                isLoading: isLoading,
                icon: icon,
                iconAtStart: iconAtStart,
                iconSpace: iconSpace,
                iconSize: iconSize,
                label: label,
                labelFont: labelFont,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
                isEnabled: onPressed != null,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ElevatedButtonChild extends StatelessWidget {
  final bool isLoading;
  final IconInfo? icon;
  final bool iconAtStart;
  final double? iconSpace;
  final double? iconSize;
  final String? label;
  final String? labelFont;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final bool isEnabled;
  final Widget? child;

  const _ElevatedButtonChild({
    this.isLoading = false,
    this.icon,
    this.iconAtStart = true,
    this.iconSpace,
    this.iconSize,
    this.label,
    this.labelFont,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.isEnabled = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (child != null) return child!;

    final effectiveColor = isEnabled
        ? (color ?? context.colors.onPrimary)
        : context.colors.subtitleTextColor;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: 150.milliseconds,
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (iconAtStart) ...[
                      icon!.buildIconWidget(
                        color: effectiveColor,
                        size: iconSize,
                      ),
                      (iconSpace ?? 4).wBox,
                    ],
                    Flexible(
                      child: CustomText(
                        label ?? '',
                        color: effectiveColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        font: labelFont,
                      ),
                    ),
                    if (!iconAtStart) ...[
                      (iconSpace ?? 4).wBox,
                      icon!.buildIconWidget(color: effectiveColor, size: iconSize),
                    ],
                  ],
                )
              : CustomText(
                  label ?? '',
                  color: effectiveColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  font: labelFont,
                ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1 : 0,
          duration: 150.milliseconds,
          child: SizedBox(
            height: 20.r,
            width: 20.r,
            child: CenterLoading.adaptive(
              color: effectiveColor,
              radius: isCupertino(context) ? 10.0 : 3.0,
            ),
          ),
        ),
      ],
    );
  }
}
