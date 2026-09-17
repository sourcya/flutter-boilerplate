part of '../../ui.dart';

class CustomIconButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconInfo? iconInfo;

  final Color? color;
  final Color? backgroundColor;

  final Color? disabledBackground;
  final Widget? child;
  final OutlinedBorder? shape;

  final double? width;
  final double? height;

  final BorderSide? borderSide;

  const CustomIconButton({
    this.margin,
    this.onPressed,
    this.isLoading = false,
    this.padding,
    this.iconInfo,
    this.disabledBackground,
    this.backgroundColor,
    this.child,
    this.width,
    this.height,
    this.shape,
    this.color,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ?? context.paddingSymmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed != null
            ? () {
                if (isLoading) return;
                onPressed!();
              }
            : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disabledBackground,
          padding: padding ?? context.paddingSymmetric(horizontal: 12, vertical: 12),
          shape: shape ?? CircleBorder(side: borderSide ?? BorderSide.none),
          backgroundColor: backgroundColor ?? context.colors.onSurface,
        ),
        child:
            child ??
            (iconInfo != null
                ? _CustomIconButtonIconContent(
                    isLoading: isLoading,
                    isEnabled: onPressed != null,
                    iconInfo: iconInfo!,
                    width: width,
                    height: height,
                    color: color,
                  )
                : null),
      ),
    );
  }
}

class _CustomIconButtonIconContent extends StatelessWidget {
  const _CustomIconButtonIconContent({
    required this.isLoading,
    required this.isEnabled,
    required this.iconInfo,
    required this.width,
    required this.height,
    required this.color,
  });

  final bool isLoading;
  final bool isEnabled;
  final IconInfo iconInfo;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: 150.milliseconds,
          child: SizedBox(
            width: width,
            height: height,
            child: iconInfo.buildIconWidget(color: color ?? context.colors.surface),
          ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1 : 0,
          duration: 150.milliseconds,
          child: SizedBox(
            height: 20.r,
            width: 20.r,
            child: CenterLoading.adaptive(
              color: isEnabled ? context.colors.surface : context.colors.subtitleTextColor,
              radius: 10.r,
              strokeWidth: 3.r,
            ),
          ),
        ),
      ],
    );
  }
}
