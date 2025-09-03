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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 6.r,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
          side: BorderSide(
            color: context.colors.subtitleTextColor ??
                context.colors.onSurface.withValues(alpha: 0.2),
            width: 1.r,
          ),
        ),
        color: context.colors.surface,
        clipBehavior: Clip.antiAlias,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: PlayxLocalization.isCurrentLocaleArabic() ? 8.r : 8.r,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize:
                  widget.isMaxWidth ? MainAxisSize.max : MainAxisSize.min,
              children: List.generate(
                widget.items.length + (widget.showAll ? 1 : 0),
                (index) {
                  if (widget.showAll && index == 0) {
                    return _buildItem(
                        item: null, isSelected: selectedItem == null);
                  }

                  final item = widget.items[widget.showAll ? index - 1 : index];

                  return _buildItem(
                    item: item,
                    isSelected: widget.isItemSelected.call(item),
                  );
                },
              ),
            ),
          ),
        ),
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
      splashColor: context.colors.primary.withValues(alpha: .2),
      borderRadius: BorderRadius.circular(24.r),
      child: AnimatedContainer(
        duration: 250.milliseconds,
        padding: EdgeInsets.symmetric(
          horizontal: 8.r,
          vertical: 6.r,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: PlayxLocalization.isCurrentLocaleArabic() ? 4.r : 4.r,
          vertical: 6.r,
        ),
        width: widget.width ?? context.width * 0.25,
        decoration: isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: AppUtils.isDarkMode()
                    ? context.colors.surfaceContainerHigh
                    : context.colors.surface,
                boxShadow: [
                  BoxShadow(
                    color: context.colors.secondary.withValues(alpha: 0.25),
                    blurRadius: 4.r,
                    offset: Offset(1, 3.r),
                  ),
                  BoxShadow(
                    color: context.colors.onSurface.withValues(alpha: 0.1),
                    blurRadius: 2.r,
                    offset: Offset(1, 2.r),
                  ),
                ],
              )
            : null,
        child: CustomText(
          item != null ? widget.itemLabel(item) : AppTrans.all,
          fontSize: PlayxLocalization.isCurrentLocaleArabic() ? 12.sp : 13.sp,
          textAlign: TextAlign.center,
          color: isSelected
              ? context.colors.secondary
              : context.colors.subtitleTextColor,
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
