part of '../../ui.dart';

class CustomOutlinedButton extends StatelessWidget {
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

  final double? minWidth;
  final double? width;
  final IconInfo? icon;
  final double? iconSpace;
  final double? iconSize;
  final bool iconAtStart;

  final bool isCompact;
  final bool isMaxWidth;

  final Gradient? gradient;
  final Color? borderColor;
  final BoxConstraints? constraints;
  final FontWeight? fontWeight;

  const CustomOutlinedButton({
    this.margin,
    this.onPressed,
    this.isLoading = false,
    this.padding,
    this.minWidth,
    this.fontSize,
    this.label,
    this.disabledBackground,
    this.child,
    this.borderRadius,
    this.width,
    this.labelFont,
    this.backgroundColor,
    this.icon,
    this.isCompact = true,
    this.color,
    this.isMaxWidth = true,
    this.iconSpace,
    this.iconSize,
    this.gradient,
    this.borderColor,
    this.iconAtStart = true,
    this.constraints,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ?? context.paddingOnly(end: 8, start: 8, top: 8, bottom: 8),
      width:
          width ??
          (isMaxWidth
              ? (context.isAppLandscape || context.width >= 1000
                    ? context.width * .4
                    : double.infinity)
              : null),
      constraints: constraints ?? (minWidth != null ? BoxConstraints(minWidth: minWidth!) : null),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius:
            borderRadius ??
            (isCompact ? Style.compactButtonBorderRadius : Style.buttonBorderRadius),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          disabledBackgroundColor: disabledBackground ?? context.colors.loginDisabledColor,
          padding:
              padding ??
              (isCompact
                  ? context.paddingSymmetric(horizontal: 12, vertical: 10)
                  : context.paddingSymmetric(horizontal: 8, vertical: 12)),
          side: BorderSide(
            color: borderColor ?? context.colors.primaryContainer,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                borderRadius ??
                (isCompact ? Style.compactButtonBorderRadius : Style.buttonBorderRadius),
          ),
          backgroundColor: gradient != null ? null : backgroundColor,
        ),
        child: _CustomOutlinedButtonContent(
          icon: icon,
          label: label,
          isLoading: isLoading,
          isEnabled: onPressed != null,
          labelFont: labelFont,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          iconAtStart: iconAtStart,
          iconSpace: iconSpace,
          iconSize: iconSize,
          child: child,
        ),
      ),
    );
  }
}

class _CustomOutlinedButtonContent extends StatelessWidget {
  const _CustomOutlinedButtonContent({
    required this.child,
    required this.icon,
    required this.label,
    required this.isLoading,
    required this.isEnabled,
    required this.labelFont,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.iconAtStart,
    required this.iconSpace,
    required this.iconSize,
  });

  final Widget? child;
  final IconInfo? icon;
  final String? label;
  final bool isLoading;
  final bool isEnabled;
  final String? labelFont;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final bool iconAtStart;
  final double? iconSpace;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    if (child != null) return child!;

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
                        color: isEnabled
                            ? (color ?? context.colors.primary)
                            : context.colors.subtitleTextColor,
                        size: iconSize,
                      ),
                      (iconSpace ?? 4).wBox,
                    ],
                    Flexible(
                      child: CustomText(
                        label ?? '',
                        color: isEnabled
                            ? (color ?? context.colors.primary)
                            : context.colors.subtitleTextColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight ?? FontWeight.w600,
                        height: 1.71,
                        font: labelFont ?? fontFamily(context: context),
                      ),
                    ),
                    if (!iconAtStart) ...[
                      (iconSpace ?? 4).wBox,
                      icon!.buildIconWidget(
                        color: isEnabled
                            ? (color ?? context.colors.primary)
                            : context.colors.subtitleTextColor,
                        size: iconSize,
                      ),
                    ],
                  ],
                )
              : CustomText(
                  label ?? '',
                  color: isEnabled
                      ? (color ?? context.colors.primary)
                      : context.colors.subtitleTextColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  font: labelFont ?? fontFamily(context: context),
                ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1 : 0,
          duration: 150.milliseconds,
          child: SizedBox(
            height: 20.r,
            width: 20.r,
            child: CenterLoading.adaptive(
              color: isEnabled
                  ? (color ?? context.colors.primary)
                  : context.colors.subtitleTextColor,
              radius: (isCupertino(context) ? 10 : 3).r,
            ),
          ),
        ),
      ],
    );
  }
}
