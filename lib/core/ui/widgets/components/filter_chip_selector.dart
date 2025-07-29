part of '../../ui.dart';

class FilterChipSelector<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T item) itemLabel;
  final IconData? Function(T item)? itemIcon;
  final Widget? Function(T item)? itemIconWidget;
  final Function(T item) onSelectedItemChanged;

  const FilterChipSelector({
    required this.items,
    required this.selectedItem,
    required this.itemLabel,
    this.itemIcon,
    this.itemIconWidget,
    required this.onSelectedItemChanged,
  });

  @override
  State<FilterChipSelector<T>> createState() => _FilterChipSelectorState<T>();
}

class _FilterChipSelectorState<T> extends State<FilterChipSelector<T>> {
  T? currentSelectedItem;

  @override
  void initState() {
    currentSelectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentSelectedItem != widget.selectedItem) {
      currentSelectedItem = widget.selectedItem;
    }
    return Container(
      width: double.infinity,
      padding: Style.mediumPadding,
      child: Wrap(
        spacing: 4.r,
        runSpacing: 4.r,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          return _buildChip(
            label: widget.itemLabel(item),
            icon: widget.itemIcon?.call(item),
            iconWidget: widget.itemIconWidget?.call(item),
            isSelected: currentSelectedItem == item,
            onTap: () {
              setState(() {
                currentSelectedItem = item;
              });
              widget.onSelectedItemChanged(item);
            },
          );
        }),
      ),
    );
  }

  Widget _buildChip({
    required String label,
    IconData? icon,
    Widget? iconWidget,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: Style.featureChipBorderRadius,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.r, horizontal: 4.r),
        child: Chip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Padding(
                  padding: EdgeInsets.all(6.0.r),
                  child: Icon(
                    icon,
                    size: 20.r,
                  ),
                ),
              ] else if (iconWidget != null) ...[
                Padding(
                  padding: EdgeInsets.all(6.0.r),
                  child: iconWidget,
                ),
              ],
              Padding(
                padding: EdgeInsets.all(6.0.r),
                child: CustomText(
                  label,
                  fontSize: 14.sp,
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.onSurface,
                  font: fontFamilyBasedOnText(label),
                ),
              ),
              if (isSelected)
                Padding(
                  padding: EdgeInsets.all(6.0.r),
                  child: Icon(
                    Icons.check,
                    size: 20.r,
                    color: context.colors.primary,
                  ),
                ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.r,
            vertical: 8.r,
          ),
          shape: isSelected
              ? RoundedRectangleBorder(
                  borderRadius: Style.featureChipBorderRadius,
                  side: BorderSide(
                    color: context.colors.primary,
                    width: 2,
                  ),
                )
              : Style.featureChipRoundedRectangleBorder,
        ),
      ),
    );
  }
}
