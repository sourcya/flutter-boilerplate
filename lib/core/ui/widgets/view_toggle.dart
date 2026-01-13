part of '../ui.dart';

/// View Toggle
class ViewToggle extends StatelessWidget {
  final bool isTableView;
  final ValueChanged<bool>? onToggle;

  const ViewToggle({super.key, required this.isTableView, this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0.r),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colors.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleButton(
            icon: IconInfo.icon(
              Icons.grid_view,
              size: 16.r,
            ),
            isSelected: !isTableView,
            onTap: () => onToggle?.call(false),
          ),
          Container(
            width: 1,
            height: 24.0.r,
            margin: EdgeInsets.symmetric(horizontal: 4.0.r),
            color: context.colors.primaryContainer,
          ),
          _ToggleButton(
            icon: IconInfo.svg(
              Assets.icons.table,
              size: 14.r,
            ),
            isSelected: isTableView,
            onTap: () => onToggle?.call(true),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final IconInfo icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const _ToggleButton({
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0.r),
        decoration: ShapeDecoration(
          color:
              isSelected ? context.colors.primaryContainer : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: icon.buildIconWidget(
          color: isSelected ? context.colors.primary : context.colors.onSurface,
        ),
      ),
    );
  }
}
