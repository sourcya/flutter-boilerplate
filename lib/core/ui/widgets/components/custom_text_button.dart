part of '../../ui.dart';

class CustomTextButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? label;
  final String? labelFont;

  final double? fontSize;
  final Color? color;

  final Color? disabledBackground;
  final Widget? child;
  final BorderRadius? borderRadius;
  final IconInfo? icon;

  final double? width;

  const CustomTextButton({
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
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ??
          EdgeInsets.only(
            right: 14.r,
            left: 14.r,
            top: 11.r,
            bottom: 11.r,
          ),
      width: width ?? double.infinity,
      child: PlatformTextButton(
        onPressed: onPressed,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 8.r,
              vertical: 16.r,
            ),
        material: (ctx, _) => MaterialTextButtonData(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disabledBackground,
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: 8.r,
                  vertical: 18.r,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? Style.buttonBorderRadius,
            ),
          ),
        ),
        cupertino: (ctx, _) => CupertinoTextButtonData(
          disabledColor: disabledBackground,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 8.r,
                vertical: 18.r,
              ),
          borderRadius: borderRadius ?? Style.buttonBorderRadius,
        ),
        child: _buildChildWidget(
          context,
          isEnabled: onPressed != null,
          labelFont: labelFont,
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
              ? CustomText.icon(
                  label ?? '',
                  icon: icon,
                  color: isEnabled
                      ? color ?? context.colors.secondary
                      : context.colors.subtitleTextColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  font: labelFont,
                )
              : CustomText(
                  label ?? '',
                  color: isEnabled
                      ? color ?? context.colors.secondary
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
                  ? context.colors.onPrimary
                  : context.colors.subtitleTextColor,
              radius: isCupertino(context) ? 10 : 3,
            ),
          ),
        ),
      ],
    );
  }
}
