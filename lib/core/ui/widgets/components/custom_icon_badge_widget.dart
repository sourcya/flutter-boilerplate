part of '../../ui.dart';

enum CustomIconBadgeSize {
  compact,
  medium,
  large,
  landscape,
}

/// Shared primary-tint icon container (list cards, details headers, info rows).
class CustomIconBadgeWidget extends StatelessWidget {
  final IconInfo icon;
  final CustomIconBadgeSize size;
  final double? padding;

  const CustomIconBadgeWidget({
    super.key,
    required this.icon,
    this.size = CustomIconBadgeSize.medium,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final (boxSize, iconSize, radius, defaultPadding) = switch (size) {
      CustomIconBadgeSize.compact => (28.0, 16.0, 8.0, 6.0),
      CustomIconBadgeSize.medium => (40.0, 24.0, 12.0, 6.0),
      CustomIconBadgeSize.large => (42.0, 24.0, 12.0, 6.0),
      CustomIconBadgeSize.landscape => (64.0, 36.0, 16.0, 10.0),
    };
    final effectivePadding = padding ?? defaultPadding;

    final child = icon.buildIconWidget(
      size: iconSize.r,
      color: context.colors.primary,
    );

    final decoration = BoxDecoration(
      color: context.colors.primaryContainer,
      borderRadius: radius.radius,
    );

    return Container(
      width: boxSize.r,
      height: boxSize.r,
      padding: context.paddingAll(effectivePadding),
      alignment: Alignment.center,
      decoration: decoration,
      child: Center(child: child),
    );
  }
}
