part of '../ui.dart';

/// Cards / table view toggle (Figma `ToggleGroup`).
class ViewToggle extends StatelessWidget {
  final bool isTableView;
  final ValueChanged<bool>? onToggle;

  const ViewToggle({super.key, required this.isTableView, this.onToggle});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    const palette = AppColors.primaryPalette;

    // Light: Figma — white shell, primary-200 border, primary-shade selected pill.
    final borderColor = isDark ? palette.primary900 : palette.primary200;
    final shellColor = isDark ? context.colors.surfaceContainerLowest : AppColors.basewhite;
    final selectedBackground = isDark ? context.colors.primaryContainer : palette.primary100;
    final selectedIconColor = isDark ? context.colors.primary : palette.primary500;
    final unselectedIconColor = isDark
        ? context.colors.onSurface.withValues(alpha: 0.6)
        : context.colors.mutedForeground;

    return Container(
      padding: context.paddingAll(4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: shellColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: 12.0.radius,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          _ToggleButton(
            icon: IconInfo.svg(Asset.icons.table, size: 16),
            isSelected: isTableView,
            selectedBackground: selectedBackground,
            selectedIconColor: selectedIconColor,
            unselectedIconColor: unselectedIconColor,
            onTap: () => onToggle?.call(true),
          ),
          Container(
            width: 1,
            height: 24,
            color: borderColor,
          ),
          _ToggleButton(
            icon: IconInfo.svg(Asset.icons.icLayoutGrid, size: 16),
            isSelected: !isTableView,
            selectedBackground: selectedBackground,
            selectedIconColor: selectedIconColor,
            unselectedIconColor: unselectedIconColor,
            onTap: () => onToggle?.call(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final IconInfo icon;
  final bool isSelected;
  final Color selectedBackground;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final VoidCallback? onTap;

  const _ToggleButton({
    required this.icon,
    required this.isSelected,
    required this.selectedBackground,
    required this.selectedIconColor,
    required this.unselectedIconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? selectedIconColor : unselectedIconColor;

    return ActionButton(
      title: '',
      onPressed: onTap,
      backgroundColor: isSelected ? selectedBackground : AppColors.transparent,
      foregroundColor: iconColor,
      icon: icon.buildIconWidget(size: 16.0.r, color: iconColor),
      padding: isSelected
          ? context.paddingSymmetric(horizontal: 8.0, vertical: 6.0)
          : context.paddingAll(8.0),
      constraints: BoxConstraints.tightFor(width: 32.0.r, height: 32.0.r),
      borderRadius: 8.0.radius,
    );
  }
}
