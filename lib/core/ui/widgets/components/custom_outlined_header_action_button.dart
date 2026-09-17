part of '../../ui.dart';

/// Outlined header action button (landscape details cards: edit, delete, etc.).
class CustomOutlinedHeaderActionButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconInfo icon;
  final bool isDestructive;

  const CustomOutlinedHeaderActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foregroundColor = isDestructive ? AppColors.semanticDestructive : colors.primary;
    final borderColor = isDestructive
        ? colors.deleteButtonBorderColor
        : AppColors.primaryPalette.primary200;
    final isDisabled = onPressed == null;
    final effectiveForegroundColor = isDisabled
        ? foregroundColor.withValues(alpha: 0.4)
        : foregroundColor;

    return ActionButton.outlined(
      title: title,
      onPressed: onPressed,
      backgroundColor: colors.cardColor,
      disabledBackgroundColor: colors.cardColor,
      foregroundColor: effectiveForegroundColor,
      borderColor: borderColor,
      borderRadius: 12.radius,
      padding: context.paddingSymmetric(horizontal: 12, vertical: 8),
      constraints: BoxConstraints(minWidth: 80.r, minHeight: 40.r),
      iconSpace: 4,
      isIconPositionLeft: true,
      icon: icon.buildIconWidget(
        size: 16.r,
        color: effectiveForegroundColor,
      ),
      textStyle: context.labelLargeTS.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.71,
        color: effectiveForegroundColor,
      ),
    );
  }
}
