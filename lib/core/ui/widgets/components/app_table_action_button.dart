part of '../../ui.dart';

/// Compact outlined action button for table action cells.
class AppTableActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String tooltip;
  final IconInfo icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double size;
  final double iconSize;

  const AppTableActionButton({
    super.key,
    required this.onPressed,
    required this.tooltip,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.size = 40,
    this.iconSize = 18,
  });

  AppTableActionButton.view({
    super.key,
    required this.onPressed,
    this.tooltip = AppTrans.viewDetails,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.size = 40,
    this.iconSize = 18,
  }) : icon = IconInfo.svg(Asset.icons.icEye);

  AppTableActionButton.edit({
    super.key,
    required this.onPressed,
    this.tooltip = AppTrans.edit,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.size = 40,
    this.iconSize = 18,
  }) : icon = IconInfo.svg(Asset.icons.icEdit);

  AppTableActionButton.delete({
    super.key,
    required this.onPressed,
    this.tooltip = AppTrans.delete,
    this.backgroundColor,
    this.foregroundColor = AppColors.semanticDestructive,
    this.borderColor,
    this.size = 40,
    this.iconSize = 18,
  }) : icon = IconInfo.svg(Asset.icons.icDelete);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final effectiveForegroundColor = foregroundColor ?? colors.primary;
    final effectiveBorderColor =
        borderColor ??
        (foregroundColor == AppColors.semanticDestructive
            ? colors.deleteButtonBorderColor
            : colors.primaryContainer);

    return Tooltip(
      message: tooltip.tr(context: context),
      child: ActionButton.outlined(
        onPressed: onPressed,
        backgroundColor: backgroundColor ?? colors.cardColor,
        foregroundColor: effectiveForegroundColor,
        borderColor: effectiveBorderColor,
        borderRadius: BorderRadius.circular(8.r),
        constraints: BoxConstraints.tightFor(width: size.r, height: size.r),
        padding: EdgeInsets.zero,
        icon: icon.buildIconWidget(
          color: effectiveForegroundColor,
          size: iconSize.r,
        ),
      ),
    );
  }
}
