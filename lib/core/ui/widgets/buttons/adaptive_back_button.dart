part of '../../ui.dart';

/// A compact back button that adapts its icon to the platform:
/// - iOS/macOS: [CupertinoIcons.back]
/// - Android/other: [Icons.arrow_back]
class AdaptiveBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? iconSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AdaptiveBackButton({
    super.key,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.height,
    this.width,
    this.iconSize,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final icon = PlayxPlatform.isCupertino
        ? CupertinoIcons.back.toIconInfo()
        : Icons.arrow_back.toIconInfo();

    final effectiveBorderRadius = 8.0.radius;
    return Container(
      height: height ?? 32.r,
      width: width ?? 32.r,
      margin: margin ?? context.paddingOnly(end: 8.0),
      decoration: BoxDecoration(
        color: context.colors.cardColor,
        borderRadius: effectiveBorderRadius,
        border: Border.all(
          color: borderColor ?? color ?? context.colors.primaryContainer,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        borderRadius: effectiveBorderRadius,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Center(
            child: Builder(
              builder: (context) {
                Widget iconWidget = icon.buildIconWidget(
                  color: color ?? context.colors.primary,
                  size: iconSize ?? 16.r,
                );
                if (context.isRtl) {
                  iconWidget = Transform.flip(flipX: true, child: iconWidget);
                }
                return iconWidget;
              },
            ),
          ),
        ),
      ),
    );
  }
}
