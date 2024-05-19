import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_colors.dart';
import '../../resources/style/style.dart';

class FilterChipSelector<T> extends StatefulWidget {
  final List<T> items;
  final T selectedItem;
  final String Function(T item) itemLabel;
  final Function(T item) onSelectedItemChanged;

  const FilterChipSelector({
    required this.items,
    required this.selectedItem,
    required this.itemLabel,
    required this.onSelectedItemChanged,
  });

  @override
  State<FilterChipSelector<T>> createState() => _FilterChipSelectorState<T>();
}

class _FilterChipSelectorState<T> extends State<FilterChipSelector<T>> {
  late T currentSelectedItem;

  @override
  void initState() {
    super.initState();
    currentSelectedItem = widget.selectedItem;
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
        spacing: 6,
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          return _buildChip(
            label: widget.itemLabel(item),
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
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? context.colors.onPrimary
                : context.colors.onChipBackgroundColor,
            fontSize: 14.sp,
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
