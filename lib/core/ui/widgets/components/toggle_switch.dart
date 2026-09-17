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
/// - Auto-scrolling to selected item (`ensureVisible`)
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

  /// Margin for the toggle switch.
  final EdgeInsetsGeometry? margin;

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

  /// Optional SVG asset path; when non-null, shown before the label with same color as text.
  final String? itemIcon;

  final String? Function(T?)? suffixChipLabel;

  /// Font size override.
  final double? fontSize;

  /// Font weight for the label text.
  final FontWeight? fontWeight;

  /// Font weight for the suffix chip label text.
  final FontWeight? suffixChipFontWeight;

  /// Color for the suffix chip label text.
  final Color? suffixChipColor;

  /// Font size for the suffix chip label text.
  final double? suffixChipFontSize;

  /// Minimum width constraint for each item.
  final double? minItemWidth;

  // Minimum width constraint for the entire toggle switch.
  final BoxConstraints? itemConstraints;

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

  /// Color of unselected item background.
  final Color? unselectedColor;

  /// Color of text/icons when unselected.
  final Color? onUnselectedColor;

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

  /// Border for selected item. Overrides [showBorder] behavior when provided.
  final BoxBorder? selectedBorder;

  /// Border for unselected item. Overrides [showBorder] behavior when provided.
  final BoxBorder? unselectedBorder;

  final Widget Function(T?)? itemLabelBuilder;
  final bool isScrollable;
  final bool ensureVisible;
  final double? bottomPaddingSpace;
  // Use on like vehicle details
  final bool underLineStyle;
  final double hScrollSpace;

  final bool showBorder;
  final double? height;
  final double borderWidth;
  final Widget Function(BuildContext context, Widget child, T? tab)? childWrapper;

  /// Padding for each individual item (overrides default item padding).
  final EdgeInsetsGeometry? itemPadding;

  /// Margin for each individual item (overrides default item margin).
  final EdgeInsetsGeometry? itemMargin;

  /// When [useNewStyle] is true, adds a light drop shadow on the selected segment.
  /// Set to false for flat segmented controls (e.g. CMDK-style toggles).
  final bool showSelectedItemShadow;

  /// Size for [iconBuilder] icons; defaults to `14.r` when null.
  final double? itemIconSize;

  /// When true and [isMaxWidth] is true (non-scrollable), applies [hScrollSpace] as gap between items.
  final bool useItemGap;

  const ToggleSwitch({
    super.key,
    this.initialItem,
    required this.items,
    required this.itemLabel,
    this.itemLabelBuilder,
    this.onItemChanged,
    this.bottomPaddingSpace,
    this.hScrollSpace = 4,
    required this.isItemSelected,
    this.iconBuilder,
    this.itemIcon,
    this.fontSize,
    this.showAll = false,
    this.isMaxWidth = false,
    this.width,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.onSelectedColor,
    this.unselectedColor,
    this.onUnselectedColor,
    this.isCompact = false,
    this.padding,
    this.borderRadius,
    this.showDivider = false,
    this.dividerColor,
    this.dividerHeight,
    this.useNewStyle = false,
    this.borderColor,
    this.selectedBorder,
    this.unselectedBorder,
    this.suffixChipLabel,
    this.isScrollable = false,
    this.ensureVisible = true,
    this.underLineStyle = false,
    this.childWrapper,
    this.margin,
    this.showBorder = false,
    this.height,
    this.borderWidth = 1,
    this.itemPadding,
    this.itemConstraints,
    this.itemMargin,
    this.showSelectedItemShadow = true,
    this.itemIconSize,
    this.fontWeight,
    this.useItemGap = false,
    this.suffixChipFontWeight,
    this.suffixChipColor,
    this.suffixChipFontSize,
    this.minItemWidth,
  });

  @override
  _ToggleSwitchState<T> createState() => _ToggleSwitchState<T>();
}

class _ToggleSwitchState<T> extends State<ToggleSwitch<T>> {
  late T? selectedItem;
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
    _rebuildKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }

  void _rebuildKeys() {
    final count = widget.items.length + (widget.showAll ? 1 : 0);
    _itemKeys
      ..clear()
      ..addAll(List.generate(count, (_) => GlobalKey()));
  }

  @override
  void didUpdateWidget(ToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _rebuildKeys();
    }
    if (oldWidget.initialItem != widget.initialItem) {
      selectedItem = widget.initialItem;
      if (widget.ensureVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
      }
    }
  }

  void _scrollToSelected() {
    if (!widget.isScrollable || !widget.ensureVisible) return;
    final totalItems = widget.items.length + (widget.showAll ? 1 : 0);
    for (int i = 0; i < totalItems && i < _itemKeys.length; i++) {
      T? item;
      if (widget.showAll && i == 0) {
        item = null;
      } else {
        final idx = widget.showAll ? i - 1 : i;
        item = widget.items[idx];
      }
      final isSelected = item == null ? selectedItem == null : widget.isItemSelected(item);
      if (isSelected) {
        final ctx = _itemKeys[i].currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            alignment: 0.5,
            duration: 200.milliseconds,
            curve: Curves.easeInOut,
          );
        }
        break;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

      final itemKey = index < _itemKeys.length ? _itemKeys[index] : GlobalKey();

      children.add(
        widget.isScrollable
            ? Padding(
                key: itemKey,
                padding: context.paddingSymmetric(horizontal: widget.hScrollSpace, vertical: widget.underLineStyle ? 0.0 : 4.0),
                child: _ToggleSwitchItem<T>(
                  toggle: widget,
                  item: item,
                  isSelected: isSelected,
                  onTapUnselected: () {
                    setState(() {
                      selectedItem = item;
                    });
                    widget.onItemChanged?.call(item);
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
                  },
                ),
              )
            : widget.isMaxWidth
            ? Expanded(
                child: _ToggleSwitchItem<T>(
                  toggle: widget,
                  item: item,
                  isSelected: isSelected,
                  onTapUnselected: () {
                    setState(() {
                      selectedItem = item;
                    });
                    widget.onItemChanged?.call(item);
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
                  },
                ),
              )
            : Flexible(
                child: _ToggleSwitchItem<T>(
                  toggle: widget,
                  item: item,
                  isSelected: isSelected,
                  onTapUnselected: () {
                    setState(() {
                      selectedItem = item;
                    });
                    widget.onItemChanged?.call(item);
                    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
                  },
                ),
              ),
      );

      if (!widget.isScrollable &&
          widget.isMaxWidth &&
          widget.useItemGap &&
          index < totalItems - 1) {
        children.add(SizedBox(width: widget.hScrollSpace.r * 2));
      }

      // Divider between items
      if (widget.showDivider && index < totalItems - 1) {
        children.add(
          Container(
            width: 1.0,
            height: widget.dividerHeight ?? 24.0.r,
            color: widget.dividerColor ?? context.colors.toggleDividerColor,
            margin: context.paddingSymmetric(horizontal: 2.0),
          ),
        );
      }
    }

    final defaultRadius = widget.isCompact ? 12.0 : 24.0;

    return CustomCard(
      width: widget.width,
      elevation: 0,
      margin: widget.margin ?? context.paddingZero(),
      shape: RoundedRectangleBorder(
        borderRadius: widget.underLineStyle
            ? BorderRadius.zero
            : widget.borderRadius ?? (widget.useNewStyle ? 12.0 : defaultRadius).radius,
        side: BorderSide(
          color: widget.underLineStyle
              ? AppColors.transparent
              : widget.borderColor ??
                    (widget.useNewStyle ? AppColors.transparent : context.colors.onSurface),
          width: widget.borderWidth,
        ),
      ),
      color: widget.underLineStyle
          ? AppColors.transparent
          : widget.useNewStyle
          ? widget.backgroundColor ?? context.colors.cardColor
          : widget.backgroundColor,
      padding:
          widget.padding ??
          (widget.useNewStyle
              ? context.paddingSymmetric(
                  horizontal: 2.0,
                  vertical: widget.bottomPaddingSpace ?? 2.0,
                )
              : context.paddingSymmetric(
                  horizontal: 4.0,
                  vertical: widget.bottomPaddingSpace ?? 4.0,
                )),
      child: widget.isScrollable
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              padding: context.paddingZero(),
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
}

class _ToggleSwitchItem<T> extends StatelessWidget {
  const _ToggleSwitchItem({
    required this.toggle,
    required this.item,
    required this.isSelected,
    required this.onTapUnselected,
  });

  final ToggleSwitch<T> toggle;
  final T? item;
  final bool isSelected;
  final VoidCallback onTapUnselected;

  @override
  Widget build(BuildContext context) {
    final icon = item != null ? toggle.iconBuilder?.call(item as T) : null;
    final label = item != null ? toggle.itemLabel(item as T) : AppTrans.all;
    final suffix = toggle.suffixChipLabel?.call(item);

    final baseRadius = toggle.underLineStyle
        ? BorderRadius.only(topLeft: 8.0.radiusCircular, topRight: 8.0.radiusCircular)
        : toggle.borderRadius ?? (toggle.isCompact || toggle.useNewStyle ? 8.0 : 12.0).radius;

    // Determine if we have a non-uniform bottom-only border (causes Flutter crash with borderRadius)
    final bool hasNonUniformBorder =
        toggle.showBorder &&
        (isSelected ? toggle.selectedBorder == null : toggle.unselectedBorder == null);

    final BoxBorder? resolvedBorder = toggle.showBorder
        ? isSelected
              ? (toggle.selectedBorder ??
                    Border.fromBorderSide(
                      BorderSide(color: context.colors.primary, width: toggle.borderWidth),
                    ))
              : (toggle.unselectedBorder ??
                    Border.fromBorderSide(
                      BorderSide(color: context.colors.borderColor, width: toggle.borderWidth),
                    ))
        : null;

    final itemPadding =
        toggle.itemPadding ??
        (toggle.useNewStyle
            ? context.paddingSymmetric(
                horizontal: (suffix != null ? 12.0 : 4.0) + (toggle.isScrollable ? 6.0 : 0),
                vertical: suffix != null ? 6.0 : 12.0,
              )
            : context.paddingSymmetric(
                horizontal: toggle.isCompact ? 8.0 : 6.0,
                vertical: toggle.isCompact ? 8.0 : 10.0,
              ));
    final animatedContainer = AnimatedContainer(
      constraints:
          toggle.itemConstraints ??
          BoxConstraints(minWidth: toggle.minItemWidth ?? (toggle.isCompact ? 56.0.r : 0)),
      duration: 200.milliseconds,
      height: toggle.height,
      padding: itemPadding,
      margin:
          toggle.itemMargin ??
          (toggle.useNewStyle
              ? context.paddingZero()
              : context.paddingSymmetric(horizontal: 2.0, vertical: 2.0)),
      decoration: BoxDecoration(
        // When border is non-uniform (bottom-only), borderRadius must be null to avoid Flutter crash.
        // Visual rounding is preserved via ClipRRect wrapper below.
        borderRadius: hasNonUniformBorder ? null : baseRadius,
        border: hasNonUniformBorder
            ? Border(
                bottom: BorderSide(
                  color: isSelected ? context.colors.primary : context.colors.borderColor,
                  width: toggle.borderWidth,
                ),
              )
            : resolvedBorder,
        color: isSelected ? toggle.selectedColor ?? context.colors.primary : toggle.unselectedColor,
        boxShadow: isSelected && toggle.useNewStyle && toggle.showSelectedItemShadow
            ? [
                BoxShadow(
                  color: context.colors.toggleShadowColor,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon.buildIconWidget(
              color: isSelected
                  ? (toggle.onSelectedColor ?? context.colors.onPrimary)
                  : (toggle.onUnselectedColor ?? toggle.color ?? context.colors.onSurface),
              size: toggle.itemIconSize ?? 14.r,
            ),
            4.0.wBox,
          ],
          Flexible(
            child:
                toggle.itemLabelBuilder?.call(item) ??
                (toggle.isMaxWidth
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          label,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          fontSize: toggle.fontSize ?? (toggle.isCompact ? 11.0.sp : 12.0.sp),
                          fontWeight: toggle.fontWeight,
                          color: isSelected
                              ? (toggle.onSelectedColor ?? context.colors.onPrimary)
                              : (toggle.onUnselectedColor ??
                                    toggle.color ??
                                    context.colors.onSurface),
                          font: fontFamilyBasedOnText(label),
                        ),
                      )
                    : CustomText(
                        label,
                        textAlign: TextAlign.center,
                        fontSize: toggle.fontSize ?? (toggle.isCompact ? 11.0.sp : 12.0.sp),
                        fontWeight: toggle.fontWeight,
                        color: isSelected
                            ? (toggle.onSelectedColor ?? context.colors.onPrimary)
                            : (toggle.onUnselectedColor ??
                                  toggle.color ??
                                  context.colors.onSurface),
                        font: fontFamilyBasedOnText(label),
                      )),
          ),

          if (suffix != null) ...[
            6.0.wBox,
            AnimatedContainer(
              duration: 200.milliseconds,
              constraints: BoxConstraints(minWidth: toggle.isCompact ? 20.0.r : 24.0.r),
              padding: context.paddingSymmetric(horizontal: 4.0, vertical: 2.0),
              margin: context.paddingZero(),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colors.secondaryContainer
                    : context.colors.infoCardBackground,
                shape: BoxShape.circle,
              ),
              child: CustomText(
                suffix,
                fontSize:
                    toggle.suffixChipFontSize ??
                    toggle.fontSize ??
                    (toggle.isCompact ? 10.0.sp : 11.0.sp),
                fontWeight: toggle.suffixChipFontWeight ?? FontWeight.w500,
                color: toggle.suffixChipColor ?? context.colors.onSurface,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );

    final inkWell = CustomInkWell(
      borderRadius: baseRadius,
      onTap: isSelected ? null : onTapUnselected,
      child: animatedContainer,
    );

    // ClipRRect preserves the visual borderRadius when BoxDecoration.borderRadius
    // cannot be set (non-uniform border sides would cause a Flutter assertion error).
    final child = hasNonUniformBorder
        ? ClipRRect(borderRadius: baseRadius, child: inkWell)
        : inkWell;

    final constrainedChild = toggle.minItemWidth != null || toggle.isCompact
        ? ConstrainedBox(
            constraints:
                toggle.itemConstraints ??
                BoxConstraints(
                  minWidth: toggle.minItemWidth ?? (toggle.isCompact ? 56.r : 0),
                ),
            child: child,
          )
        : child;

    return toggle.childWrapper?.call(context, constrainedChild, item) ?? constrainedChild;
  }
}
