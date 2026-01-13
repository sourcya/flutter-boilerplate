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
  final bool useNewStyle;
  final bool selectAllOnAll;

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
    this.useNewStyle = false,
    this.selectAllOnAll = false,
  });

  @override
  State<FilterMultipleChipSelector<T>> createState() =>
      _FilterMultiChipSelectorState<T>();
}

class _FilterMultiChipSelectorState<T>
    extends State<FilterMultipleChipSelector<T>> {
  List<T> currentSelectedItems = <T>[];
  bool isAllSelected = false;

  /// Helper to determine if "All" is currently active based on list state
  bool _calculateIsAllSelected(List<T> items) {
    final allItemsSelected = items.length == widget.items.length;

    // If selectAllOnAll is TRUE:
    // "All" is only true if actual items are selected. Empty list means "None".
    if (widget.selectAllOnAll) {
      return allItemsSelected;
    }

    // If selectAllOnAll is FALSE (Default behavior):
    // "All" is true if items are empty (implicit all) OR if all items are physically selected.
    return allItemsSelected || items.isEmpty;
  }

  @override
  void initState() {
    super.initState();
    currentSelectedItems.assignAll(widget.selectedItems);

    isAllSelected = _calculateIsAllSelected(currentSelectedItems);

    // Initial Cleanup:
    // If default mode (selectAllOnAll=false) and we determined "All" is selected,
    // ensure internal list is empty to match "Empty=All" convention.
    if (isAllSelected &&
        currentSelectedItems.isNotEmpty &&
        !widget.selectAllOnAll) {
      currentSelectedItems.clear();
    }
  }

  @override
  void didUpdateWidget(covariant FilterMultipleChipSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    final selectedChanged = !listEquals(
      widget.selectedItems,
      currentSelectedItems,
    );
    final itemsChanged = !listEquals(widget.items, oldWidget.items);
    final styleChanged = widget.useNewStyle != oldWidget.useNewStyle;
    final selectAllOptionChanged =
        widget.selectAllOnAll != oldWidget.selectAllOnAll;

    if (!selectedChanged &&
        !itemsChanged &&
        !styleChanged &&
        !selectAllOptionChanged)
      return;

    // Start from the incoming selected items
    currentSelectedItems.assignAll(widget.selectedItems);

    // Remove any selections that no longer exist in the available items
    currentSelectedItems.retainWhere((item) => widget.items.contains(item));

    // If new style is enabled, enforce single-select behavior
    if (widget.useNewStyle && currentSelectedItems.length > 1) {
      currentSelectedItems = [currentSelectedItems.first];
    }

    // Recalculate "All" state
    isAllSelected = _calculateIsAllSelected(currentSelectedItems);

    // Consistency Checks based on flag
    if (isAllSelected) {
      if (!widget.selectAllOnAll && currentSelectedItems.isNotEmpty) {
        // Default mode: All selected implies empty list
        currentSelectedItems.clear();
      } else if (widget.selectAllOnAll && currentSelectedItems.isEmpty) {
        // New mode: All selected implies full list (if passing from parent as empty=all)
        currentSelectedItems.assignAll(widget.items);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Style.mediumPadding,
      child: Wrap(
        spacing: widget.useNewStyle ? 8.0.r : 6.r,
        runSpacing: widget.useNewStyle ? 12.0.r : 6.r,
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
              isSelected: currentSelectedItems.contains(item),
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
    // ... (This section remains unchanged from your previous provided code)
    if (widget.useNewStyle) {
      final selectedColor =
          widget.selectedColor ?? context.colors.primaryContainer;
      final backgroundColor =
          widget.backgroundColor ?? context.colors.cardColor;
      final onSelectedColor =
          widget.onSelectedColor ?? context.colors.onPrimary;
      final onBackgroundColor =
          widget.onBackgroundColor ?? context.colors.onSurface;

      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? context.colors.primary
                  : context.colors.borderColor,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.isMobile ? 16.r : 24.0.r,
            vertical: 10.0.r,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CustomText(
                  label,
                  fontSize: 14.sp,
                  color: isSelected
                      ? context.colors.primary
                      : onBackgroundColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  font: fontFamilyBasedOnText(label),
                ),
              ),
              SizedBox(width: context.isMobile ? 16.r : 24.0.r),
              Container(
                width: 18.r,
                height: 18.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? context.colors.primary : null,
                  border: Border.all(
                    color: isSelected
                        ? context.colors.primary
                        : onBackgroundColor.withValues(alpha: 0.5),
                    width: isSelected ? 0.0 : 1.0,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 14.r,
                        color: context.colors.onPrimary,
                      )
                    : null,
              ),
            ],
          ),
        ),
      );
    } else {
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
                          : widget.onBackgroundColor ??
                                context.colors.onSurface,
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
  }

  void _handleAllSelected() {
    if (isAllSelected) {
      // It is already selected. User tapped it again to toggle it OFF.
      if (widget.selectAllOnAll) {
        // If we are in "Physical Select" mode, we clear everything.
        // This creates a state where NOTHING is selected.
        currentSelectedItems.clear();
        isAllSelected = false;
      } else {
        // If we are in default "Empty = All" mode:
        // Tapping "All" again usually just reaffirms "Clear filters".
        // We cannot really "Deselect All" to show nothing in this mode,
        // so we just ensure it's cleared.
        currentSelectedItems.clear();
        isAllSelected = true;
      }
    } else {
      // It was NOT selected. User tapped it to toggle it ON.
      isAllSelected = true;
      if (widget.selectAllOnAll) {
        currentSelectedItems.assignAll(widget.items);
      } else {
        currentSelectedItems.clear();
      }
    }

    setState(() {});
    widget.onSelectedItemsChanged(currentSelectedItems);
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

    // Recalculate All state based on new list
    isAllSelected = _calculateIsAllSelected(items);

    // If 'selectAllOnAll' is FALSE (Default), we clear the list when everything is selected
    // to maintain the "empty list = all" logic.
    if (isAllSelected && !widget.selectAllOnAll) {
      items.clear();
    }

    setState(() {
      currentSelectedItems.assignAll(items);
      widget.onSelectedItemsChanged(items);
    });
  }
}
