part of '../../ui.dart';

/// A customizable horizontal toggle switch used to select one item from a list.
///
/// Supports:
/// - Optional “All” item (`showAll`)
/// - Icons per item
/// - Compact mode
/// - Dividers between items
/// - Custom colors / spacing / radius
/// - New modern UI style (`useNewStyle`)
///
/// When [useNewStyle] is true:
/// - Background becomes light grey
/// - Selected item is a filled rounded pill
/// - Unselected items have no border and no filled background
/// - Text/icon colors match modern segmented control styling
///
class ToggleSwitch<T> extends StatefulWidget {
  /// The initially selected item.
  final T? initialItem;

  /// List of selectable items.
  final List<T> items;

  /// Callback fired when the selected item changes.
  final Function(T?)? onItemChanged;

  /// Provides the string label for each item.
  final String Function(T) itemLabel;

  /// Determines if an item is selected.
  final bool Function(T) isItemSelected;

  /// Optional builder for item icons.
  final IconInfo? Function(T)? iconBuilder;

  final String? Function(T?)? suffixChipLabel;

  /// Font size override.
  final double? fontSize;

  /// Whether to insert an “All” item at index 0.
  final bool showAll;

  /// Makes the toggle expand horizontally.
  final bool isMaxWidth;

  /// Override width.
  final double? width;

  /// Background container color (ignored when [useNewStyle] is true).
  final Color? backgroundColor;

  /// Default text/icon color (unselected state).
  final Color? color;

  /// Color of selected item background.
  final Color? selectedColor;

  /// Color of text/icons when selected.
  final Color? onSelectedColor;

  /// Reduces padding.
  final bool isCompact;

  /// Custom padding for container.
  final EdgeInsetsGeometry? padding;

  /// Border radius override.
  final BorderRadius? borderRadius;

  /// Whether to show a divider between items.
  final bool showDivider;

  /// Divider line color.
  final Color? dividerColor;

  /// Divider height.
  final double? dividerHeight;

  /// Enables the new UI style (pill design, light grey background).
  final bool useNewStyle;

  final Color? borderColor;

  final Widget Function(T?)? itemLabelBuilder;
  final bool isScrollable;

  final Widget Function(BuildContext context, Widget child, T? tab)? childWrapper;

  const ToggleSwitch({
    super.key,
    this.initialItem,
    required this.items,
    required this.itemLabel,
    this.itemLabelBuilder,
    this.onItemChanged,
    required this.isItemSelected,
    this.iconBuilder,
    this.fontSize,
    this.showAll = false,
    this.isMaxWidth = false,
    this.width,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.onSelectedColor,
    this.isCompact = false,
    this.padding,
    this.borderRadius,
    this.showDivider = false,
    this.dividerColor,
    this.dividerHeight,
    this.useNewStyle = false,
    this.borderColor,
    this.suffixChipLabel,
    this.isScrollable = false,
    this.childWrapper,
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
  void didUpdateWidget(ToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialItem != widget.initialItem) {
      selectedItem = widget.initialItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final totalItems = widget.items.length + (widget.showAll ? 1 : 0);

    for (int index = 0; index < totalItems; index++) {
      T? item;
      bool isSelected;

      if (widget.showAll && index == 0) {
        item = null;
        isSelected = selectedItem == null;
      } else {
        final itemIndex = widget.showAll ? index - 1 : index;
        item = widget.items[itemIndex];
        isSelected = item != null && widget.isItemSelected(item);
      }

      children.add(
        widget.isScrollable
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.r, vertical: 4.r),
                child: _buildItem(item: item, isSelected: isSelected),
              )
            : Expanded(
                child: _buildItem(item: item, isSelected: isSelected),
              ),
      );

      // Divider between items
      if (widget.showDivider && index < totalItems - 1) {
        children.add(
          Container(
            width: 1,
            height: widget.dividerHeight ?? 24.r,
            color: widget.dividerColor ?? const Color(0xFFEAECF0),
            margin: EdgeInsets.symmetric(horizontal: 2.r),
          ),
        );
      }
    }

    final defaultRadius = BorderRadius.circular(widget.isCompact ? 12.r : 24.r);

    return CustomCard(
      width: widget.width,
      elevation: 0,
      shouldShowCustomShadow: false,
      shape: RoundedRectangleBorder(
        borderRadius: widget.useNewStyle
            ? BorderRadius.circular(12.r)
            : (widget.borderRadius ?? defaultRadius),
        side: BorderSide(
          color:
              widget.borderColor ??
              (widget.useNewStyle ? Colors.transparent : context.colors.onSurface),
        ),
      ),
      color: widget.useNewStyle
          ? widget.backgroundColor ?? context.colors.cardColor
          : widget.backgroundColor,
      padding: widget.useNewStyle
          ? EdgeInsets.symmetric(horizontal: 2.r, vertical: 2.r)
          : widget.padding ?? EdgeInsets.symmetric(horizontal: 4.r, vertical: 4.r),
      child: widget.isScrollable
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: widget.isMaxWidth ? MainAxisSize.max : MainAxisSize.min,
                children: children,
              ),
            )
          : Row(
              mainAxisSize: widget.isMaxWidth ? MainAxisSize.max : MainAxisSize.min,
              children: children,
            ),
    );
  }

  Widget _buildItem({required T? item, required bool isSelected}) {
    final icon = item != null ? widget.iconBuilder?.call(item) : null;
    final label = item != null ? widget.itemLabel(item) : AppTrans.all;
    final suffix = widget.suffixChipLabel?.call(item);

    final baseRadius =
        widget.borderRadius ??
        BorderRadius.circular(
          widget.isCompact || widget.useNewStyle ? 12.r : 24.r,
        );

    final child = InkWell(
      borderRadius: baseRadius,
      onTap: isSelected
          ? null
          : () {
              setState(() {
                selectedItem = item;
              });
              widget.onItemChanged?.call(item);
            },
      child: AnimatedContainer(
        duration: 200.milliseconds,
        padding: widget.useNewStyle
            ? EdgeInsets.symmetric(
                horizontal: (suffix != null ? 12.r : 4.r) + (widget.isScrollable ? 6.r : 0),
                vertical: suffix != null ? 4.r : 8.r,
              )
            : EdgeInsets.symmetric(
                horizontal: widget.isCompact ? 8.r : 6.r,
                vertical: widget.isCompact ? 8.r : 10.r,
              ),
        margin: widget.useNewStyle
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: 2.r, vertical: 2.r),
        decoration: BoxDecoration(
          borderRadius: baseRadius,
          color: isSelected ? widget.selectedColor ?? context.colors.primary : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon.buildIconWidget(
                color: isSelected
                    ? (widget.onSelectedColor ?? context.colors.onPrimary)
                    : (widget.color ?? context.colors.onSurface),
                size: 14.r,
              ),
              SizedBox(width: 4.r),
            ],
            Flexible(
              child:
                  widget.itemLabelBuilder?.call(item) ??
                  CustomText(
                    label,
                    textAlign: TextAlign.center,
                    fontSize: widget.fontSize ?? (widget.isCompact ? 11.sp : 12.sp),
                    color: isSelected
                        ? (widget.onSelectedColor ?? context.colors.onPrimary)
                        : (widget.color ?? context.colors.onSurface),
                    font: fontFamilyBasedOnText(label),
                  ),
            ),

            if (suffix != null) ...[
              SizedBox(width: 6.r),
              Chip(
                backgroundColor: context.colors.secondaryContainer,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(9999),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.r),
                labelPadding: EdgeInsets.symmetric(horizontal: 4.r),
                label: CustomText(
                  suffix,
                  fontSize: widget.fontSize ?? (widget.isCompact ? 11.sp : 12.sp),
                  fontWeight: FontWeight.w500,
                  color: context.colors.onSecondaryContainer,
                ),
              ),
            ],
          ],
        ),
      ),
    );
    return widget.childWrapper?.call(context, child, item) ?? child;
  }
}
