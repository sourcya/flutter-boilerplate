part of '../../ui.dart';

class DetailsInfoRowIcon extends StatelessWidget {
  final Color? iconBgColor;
  final Color? iconColor;
  final IconInfo icon;

  const DetailsInfoRowIcon({
    super.key,
    this.iconBgColor,
    this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingAll(4.0),
      decoration: ShapeDecoration(
        color: iconBgColor ?? context.colors.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: 6.radius),
      ),
      child: icon.buildIconWidget(
        color: iconColor ?? context.colors.primary,
        size: 16.r,
      ),
    );
  }
}
