part of '../../ui.dart';

class ToggleSwitch<T> extends StatefulWidget {
  final T? initialItem;
  final List<T> items;
  final Function(T?)? onItemChanged;
  final String Function(T) itemLabel;
  final bool Function(T) isItemSelected;
  final bool showAll;
  final bool isMaxWidth;
  final double? width;

  const ToggleSwitch({
    super.key,
    this.initialItem,
    required this.items,
    required this.itemLabel,
    this.onItemChanged,
    required this.isItemSelected,
    this.showAll = false,
    this.isMaxWidth = false,
    this.width,
  });

  @override
  _ToggleSwitchState<T> createState() => _ToggleSwitchState<T>();
}

class _ToggleSwitchState<T> extends State<ToggleSwitch<T>> {
  late T? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      shadowBorderRadius: BorderRadius.circular(24.r),
      padding: EdgeInsets.zero,
      width: widget.width,
      child: Row(
        mainAxisSize: widget.isMaxWidth ? MainAxisSize.max : MainAxisSize.min,
        children: List.generate(widget.items.length + (widget.showAll ? 1 : 0),
            (index) {
          if (widget.showAll && index == 0) {
            return Expanded(
              child: _buildItem(item: null, isSelected: selectedItem == null),
            );
          }

          final item = widget.items[widget.showAll ? index - 1 : index];

          return Expanded(
            child: _buildItem(
              item: item,
              isSelected: widget.isItemSelected.call(item),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildItem({required T? item, required bool isSelected}) {
    return InkWell(
      onTap: isSelected
          ? null
          : () {
              setState(() {
                if (item == null) {
                  selectedItem = null;
                  widget.onItemChanged?.call(null);
                } else {
                  selectedItem = item;
                  widget.onItemChanged?.call(item);
                }
              });
            },
      borderRadius: BorderRadius.circular(24.r),
      child: AnimatedContainer(
        duration: 250.milliseconds,
        padding: EdgeInsets.symmetric(
          horizontal:
              PlayxLocalization.isCurrentLocaleArabic() ? 12.0.r : 8.0.r,
          vertical: 16.r,
        ),
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: context.colors.primary,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.onSurface.withValues(alpha: 0.2),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.r),
                  ),
                ],
              )
            : null,
        width: widget.isMaxWidth ? double.infinity : null,
        child: CustomText(
          item != null ? widget.itemLabel(item) : AppTrans.all,
          fontSize: 13.sp,
          textAlign: TextAlign.center,
          color:
              isSelected ? context.colors.onPrimary : context.colors.onSurface,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(ToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialItem != widget.initialItem) {
      selectedItem = widget.initialItem;
    }
  }
}
