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
  final IconInfo? icon;
  final double? iconSpace;
  final double? iconSize;
  final bool iconAtStart;

  final bool isCompact;
  final bool isMaxWidth;

  final Gradient? gradient;
  final Color? borderColor;

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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          margin ??
          EdgeInsets.only(right: 14.r, left: 14.r, top: 11.r, bottom: 11.r),
      width:
          width ??
          (isMaxWidth
              ? (context.isLandscape || context.width >= 1000
                    ? context.width * .4
                    : double.infinity)
              : null),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius:
            borderRadius ??
            (isCompact
                ? Style.compactButtonBorderRadius
                : Style.buttonBorderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              borderRadius ??
              (isCompact
                  ? Style.compactButtonBorderRadius
                  : Style.buttonBorderRadius),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: PlatformElevatedButton(
          onPressed: onPressed,
          padding:
              padding ??
              (isCompact
                  ? EdgeInsets.symmetric(horizontal: 8.r, vertical: 12.r)
                  : EdgeInsets.symmetric(horizontal: 8.r, vertical: 16.r)),
          material: (ctx, _) => MaterialElevatedButtonData(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor:
                  disabledBackground ??
                  context.colors.disabledButtonBackgroundColor,
              padding:
                  padding ??
                  (isCompact
                      ? EdgeInsets.symmetric(horizontal: 8.r, vertical: 12.r)
                      : EdgeInsets.symmetric(horizontal: 8.r, vertical: 18.r)),
              shape: RoundedRectangleBorder(
                borderRadius:
                    borderRadius ??
                    (isCompact
                        ? Style.compactButtonBorderRadius
                        : Style.buttonBorderRadius),
                side: borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
              ),
              backgroundColor: gradient != null
                  ? Colors.transparent
                  : backgroundColor ?? context.colors.primary,
            ),
          ),
          color: gradient != null
              ? Colors.transparent
              : backgroundColor ?? context.colors.primary,
          cupertino: (ctx, _) => CupertinoElevatedButtonData(
            disabledColor:
                disabledBackground ??
                context.colors.disabledButtonBackgroundColor,
            padding:
                padding ??
                (isCompact
                    ? EdgeInsets.symmetric(horizontal: 8.r, vertical: 12.r)
                    : EdgeInsets.symmetric(horizontal: 8.r, vertical: 18.r)),
            borderRadius:
                borderRadius ??
                (isCompact
                    ? Style.compactButtonBorderRadius
                    : Style.buttonBorderRadius),
          ),
          child: _buildChildWidget(
            context,
            isEnabled: onPressed != null,
            labelFont: labelFont,
          ),
        ),
      ),
    );
  }

  Widget _buildChildWidget(
    BuildContext context, {
    required bool isEnabled,
    String? labelFont,
  }) {
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
                            ? (color ?? context.colors.onPrimary)
                            : context.colors.subtitleTextColor,
                        size: iconSize,
                      ),
                      SizedBox(width: iconSpace ?? 4.r),
                    ],
                    Flexible(
                      child: CustomText(
                        label ?? '',
                        color: isEnabled
                            ? (color ?? context.colors.onPrimary)
                            : context.colors.subtitleTextColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w400,
                        font: labelFont,
                      ),
                    ),
                    if (!iconAtStart) ...[
                      SizedBox(width: iconSpace ?? 4.r),
                      icon!.buildIconWidget(
                        color: isEnabled
                            ? (color ?? context.colors.onPrimary)
                            : context.colors.subtitleTextColor,
                        size: iconSize,
                      ),
                    ],
                  ],
                )
              : CustomText(
                  label ?? '',
                  color: isEnabled
                      ? (color ?? context.colors.onPrimary)
                      : context.colors.subtitleTextColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  font: labelFont,
                ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1 : 0,
          duration: 150.milliseconds,
          child: SizedBox(
            height: 20,
            width: 20,
            child: CenterLoading.adaptive(
              color: isEnabled
                  ? (color ?? context.colors.onPrimary)
                  : context.colors.subtitleTextColor,
              radius: isCupertino(context) ? 10 : 3,
            ),
          ),
        ),
      ],
    );
  }
}
