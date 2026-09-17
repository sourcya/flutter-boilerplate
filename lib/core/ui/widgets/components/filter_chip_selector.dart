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
      padding: Style.mediumPadding(context),
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
        padding: context.paddingSymmetric(vertical: 4.0, horizontal: 4),
        child: Chip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Padding(
                  padding: context.paddingAll(6.0),
                  child: Icon(
                    icon,
                    size: 20.r,
                  ),
                ),
              ] else if (iconWidget != null) ...[
                Padding(
                  padding: context.paddingAll(6.0),
                  child: iconWidget,
                ),
              ],
              Padding(
                padding: context.paddingAll(6.0),
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
                  padding: context.paddingAll(6.0),
                  child: Icon(
                    Icons.check,
                    size: 20.r,
                    color: context.colors.primary,
                  ),
                ),
            ],
          ),
          padding: context.paddingSymmetric(horizontal: 8, vertical: 8),
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
