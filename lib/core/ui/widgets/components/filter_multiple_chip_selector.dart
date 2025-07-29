part of '../../ui.dart';

class FilterMultipleChipSelector<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String allLabel;
  final String Function(T item) itemLabel;
  final IconInfo Function(T item)? itemIcon;
  final Function(List<T> selectedItems) onSelectedItemsChanged;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? onBackgroundColor;
  final Color? onSelectedColor;

  const FilterMultipleChipSelector({
    required this.items,
    required this.selectedItems,
    required this.allLabel,
    required this.onSelectedItemsChanged,
    required this.itemLabel,
    this.itemIcon,
    this.backgroundColor,
    this.selectedColor,
    this.onBackgroundColor,
    this.onSelectedColor,
  });

  @override
  State<FilterMultipleChipSelector<T>> createState() =>
      _FilterMultiChipSelectorState<T>();
}

class _FilterMultiChipSelectorState<T>
    extends State<FilterMultipleChipSelector<T>> {
  List<T> currentSelectedItems = <T>[];
  bool isAllSelected = false;

  @override
  void initState() {
    currentSelectedItems.assignAll(widget.selectedItems);
    isAllSelected = widget.selectedItems.length == widget.items.length ||
        currentSelectedItems.isEmpty;
    if (isAllSelected && currentSelectedItems.isNotEmpty) {
      currentSelectedItems.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Style.mediumPadding,
      child: Wrap(
        spacing: 6.r,
        runSpacing: 6.r,
        children: [
          _buildChip(
            label: widget.allLabel,
            isSelected: isAllSelected,
            context: context,
            onTap: _handleAllSelected,
          ),
          ...List.generate(widget.items.length, (index) {
            final item = widget.items[index];

            return _buildChip(
              label: widget.itemLabel(item),
              context: context,
              isSelected: currentSelectedItems.contains(
                item,
              ),
              onTap: () => _handleItemSelection(item),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required VoidCallback onTap,
    bool isSelected = false,
    IconInfo? icon,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: Style.featureChipBorderRadius,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.r),
        child: Chip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.all(6.0.r),
                  child: Icon(
                    icon.icon,
                    size: 16.r,
                    color: isSelected
                        ? widget.onSelectedColor ?? context.colors.onPrimary
                        : widget.onBackgroundColor ?? context.colors.onSurface,
                  ),
                ),
              SizedBox(width: icon != null ? 4.r : 0),
              Flexible(
                child: CustomText(
                  label,
                  fontSize: 14.sp,
                  color: isSelected
                      ? widget.onSelectedColor ?? context.colors.onPrimary
                      : widget.onBackgroundColor ?? context.colors.onSurface,
                ),
              ),
              SizedBox(width: 4.r),
              if (isSelected)
                Icon(
                  Icons.check,
                  size: 16.r,
                  color: widget.onSelectedColor ?? context.colors.onPrimary,
                ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.0.r, vertical: 8.r),
          shape: Style.featureChipRoundedRectangleBorder,
          backgroundColor: isSelected
              ? widget.selectedColor ?? context.colors.primary
              : widget.backgroundColor ?? context.colors.surface,
        ),
      ),
    );
  }

  void _handleAllSelected() {
    isAllSelected = true;
    currentSelectedItems.clear();

    setState(() {});
    widget.onSelectedItemsChanged([]);
  }

  void _handleItemSelection(T item) {
    if (widget.items.length <= 2) {
      final items = [item];
      currentSelectedItems.assignAll(items);
      isAllSelected = false;
      setState(() {
        widget.onSelectedItemsChanged(items);
      });
      return;
    }
    final items = currentSelectedItems.toList();
    if (currentSelectedItems.contains(item)) {
      items.remove(item);
    } else {
      items.add(item);
    }

    isAllSelected = items.length == widget.items.length || items.isEmpty;
    if (isAllSelected) {
      items.clear();
    }
    setState(() {
      currentSelectedItems.assignAll(items);
      widget.onSelectedItemsChanged(items);
    });
  }
}
