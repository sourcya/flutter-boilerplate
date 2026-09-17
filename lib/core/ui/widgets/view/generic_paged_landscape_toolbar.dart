part of '../../ui.dart';

/// Segmented status tabs (Figma `PageHeader` filter strip only).
class PagedSegmentedTabBar extends StatelessWidget {
  const PagedSegmentedTabBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.selectedIndexRx,
    this.onSelected,
    this.expand = false,
  });

  final List<String> items;
  final int selectedIndex;
  final RxInt? selectedIndexRx;
  final ValueChanged<int>? onSelected;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    Widget strip(int rawIndex) {
      final colors = context.colors;
      final isDark = context.isDarkMode;
      final active = rawIndex.clamp(0, items.length - 1);
      final shellColor = isDark ? colors.cardColor : AppColors.basewhite;
      final tabFill = isDark ? colors.cardColor : AppColors.basewhite;

      return Container(
        width: expand ? context.width : null,
        padding: context.paddingAll(4),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: shellColor,
          shape: RoundedRectangleBorder(borderRadius: 8.radius),
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          children: List.generate(items.length, (index) {
            final selected = index == active;
            final tab = ActionButton(
              title: items[index],
              onPressed: onSelected != null ? () => onSelected!(index) : null,
              backgroundColor: selected ? colors.primary : tabFill,
              foregroundColor: selected ? colors.onPrimary : colors.mutedForeground,
              borderRadius: 8.radius,
              padding: context.paddingSymmetric(horizontal: 16, vertical: 6),
              constraints: BoxConstraints(
                minWidth: 56.r,
                minHeight: 32.r,
                maxHeight: 32.r,
              ),
              textStyle: context.labelMediumTS.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                height: 1.43,
                color: selected ? colors.onPrimary : colors.mutedForeground,
              ),
              shadows: selected ? AppShadows.helpChipShadow : null,
            );
            return expand ? Expanded(child: tab) : tab;
          }),
        ),
      );
    }

    if (selectedIndexRx != null) {
      return Obx(() => strip(selectedIndexRx?.value ?? 0));
    }
    return strip(selectedIndex);
  }
}
