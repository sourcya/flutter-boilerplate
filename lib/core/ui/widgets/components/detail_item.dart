part of '../../ui.dart';

/// The detail item widget that can display either a text value, a custom widget,
/// or a ReportTypeChip via convenient dedicated properties.
class DetailItem extends StatelessWidget {
  const DetailItem({
    super.key,
    this.icon,
    required this.label,
    this.value = '',
    this.detailWidget,
    this.chipText,
    this.chipColor,
    this.chipIcon,
    this.chipBackgroundColor,
    this.chipBorderColor,
    this.contentTxtColor,
    this.contentTxtWeight,
    this.contentTxtSize,
    this.selectable = false,
    this.isHorizontal = false,
    this.isCenter = false,
    this.chipPadding,
    this.contentTxtAlign,
  });

  /// The optional leading icon.
  final IconInfo? icon;
  final bool isHorizontal;
  final TextAlign? contentTxtAlign;

  /// The top label (subtitle/description).
  final String label;
  final Color? contentTxtColor;
  final FontWeight? contentTxtWeight;

  /// The default text value (only used if detailWidget and chipText are null).
  final String value;

  /// The optional widget to display as the main detail (e.g., a pre-built chip).
  final Widget? detailWidget;

  // --- New Chip Properties ---
  /// Text for the convenient ReportTypeChip. If provided, overrides 'value' (unless detailWidget is present).
  final String? chipText;

  /// Color for the convenient ReportTypeChip. Required if chipText is provided.
  final Color? chipColor;

  /// Icon for the convenient ReportTypeChip.
  final IconInfo? chipIcon;

  /// Background color for the convenient ReportTypeChip.
  final Color? chipBackgroundColor;

  final Color? chipBorderColor;
  final EdgeInsetsGeometry? chipPadding;

  final bool isCenter;

  final double? contentTxtSize;

  /// Whether the text value should be selectable.
  final bool selectable;
  // -------------------------

  @override
  Widget build(BuildContext context) {
    // 1. Determine the main content widget based on priority
    Widget contentWidget;
    if (detailWidget != null) {
      contentWidget = detailWidget!;
    } else if (chipText != null && chipColor != null) {
      // Use convenience properties to build the chip
      contentWidget = CustomTypeChip(
        text: chipText,
        color: chipColor!,
        txtSize: contentTxtSize,
        icon: chipIcon,
        backgroundColor: chipBackgroundColor,
        borderColor: chipBorderColor,
        addBorderSide: chipBorderColor != null,
        padding: chipPadding,
      );
    } else {
      // Fallback to the default text value
      contentWidget = CustomText(
        value,
        fontSize: contentTxtSize ?? (context.isAppLandscape ? 14.0.sp : 13.sp),
        color: contentTxtColor ?? context.colors.onSurface,
        fontWeight: contentTxtWeight ?? FontWeight.w500,
        font: fontFamilyBasedOnText(value),
        textAlign: contentTxtAlign ?? TextAlign.start,
        isSelectable: selectable,
      );
    }

    // 2. Build the main Row structure
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Padding(
            padding: context.paddingOnly(start: 4, end: 4, bottom: 4),
            child: icon!.buildIconWidget(
              color: context.colors.subtitleTextColor,
              size: context.isAppLandscape ? 18.0.r : 16.r,
            ),
          ),
        if (!isHorizontal)
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              spacing: 6.r,
              children: [
                CustomText(
                  label,
                  fontSize: 13.sp,
                  color: context.colors.subtitleTextColor,
                  font: fontFamilyBasedOnText(label),
                ),
                contentWidget,
              ],
            ),
          )
        else
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8.r,
              children: [
                CustomText(
                  label,
                  fontSize: 13.sp,
                  color: context.colors.subtitleTextColor,
                  font: fontFamilyBasedOnText(label),
                ),
                Flexible(child: contentWidget),
              ],
            ),
          ),
      ],
    );
  }
}
