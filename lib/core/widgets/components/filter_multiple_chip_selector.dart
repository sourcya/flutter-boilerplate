import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_colors.dart';
import '../../resources/style/style.dart';

class FilterMultipleChipSelector<T> extends StatefulWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String allLabel;
  final String Function(T item) itemLabel;
  final Function(List<T> selectedItems) onSelectedItemsChanged;

  const FilterMultipleChipSelector({
    required this.items,
    required this.selectedItems,
    required this.allLabel,
    required this.onSelectedItemsChanged,
    required this.itemLabel,
  });

  @override
  State<FilterMultipleChipSelector<T>> createState() =>
      _FilterChipSelectorState<T>();
}

class _FilterChipSelectorState<T> extends State<FilterMultipleChipSelector<T>> {
  late List<T> currentSelectedItems;

  @override
  void initState() {
    currentSelectedItems = widget.selectedItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Style.mediumPadding,
      child: Wrap(
        spacing: 6,
        children: [
          _buildChip(
            label: widget.allLabel,
            isSelected: currentSelectedItems.isEmpty,
            onTap: () {
              setState(() {
                if (widget.selectedItems.isNotEmpty) {
                  currentSelectedItems.clear();
                }
              });
              widget.onSelectedItemsChanged(currentSelectedItems);
            },
          ),
          ...List.generate(widget.items.length, (index) {
            final item = widget.items[index];

            return _buildChip(
              label: widget.itemLabel(item),
              isSelected: currentSelectedItems.contains(
                item,
              ),
              onTap: () {
                final isAdded = currentSelectedItems.contains(item);
                if (isAdded) {
                  final list = currentSelectedItems.toList();
                  list.remove(item);
                  currentSelectedItems = list;
                } else {
                  final list = currentSelectedItems.toList();
                  list.add(item);
                  currentSelectedItems = list;
                  if (currentSelectedItems.length == widget.items.length) {
                    currentSelectedItems.clear();
                  }
                }
                setState(() {});
                widget.onSelectedItemsChanged(currentSelectedItems);
              },
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
  }) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: isSelected
                ? context.colors.onPrimary
                : context.colors.onChipBackgroundColor,
          ),
        ),
        shape: Style.featureChipRoundedRectangleBorder,
        backgroundColor: isSelected
            ? context.colors.primary
            : context.colors.chipBackgroundColor,
      ),
    );
  }
}
