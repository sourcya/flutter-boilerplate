part of '../../ui.dart';

/// Reusable label + value row with a primary-tint icon badge (details cards, info sections).
class CustomInfoRowWidget extends StatelessWidget {
  final IconInfo icon;
  final String label;
  final Widget content;
  final bool hasBottomDivider;
  final bool _compact;

  const CustomInfoRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.content,
    this.hasBottomDivider = false,
  }) : _compact = false;

  /// Inline info row for landscape grids (no vertical padding or dividers).
  const CustomInfoRowWidget.compact({
    super.key,
    required this.icon,
    required this.label,
    required this.content,
  }) : hasBottomDivider = false,
       _compact = true;

  /// Standard 16sp foreground value used in details info rows.
  static Widget valueText(BuildContext context, String text) {
    return CustomText(
      text,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: context.colors.cardForeground,
      height: 1,
      isTranslatable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      spacing: 8.0.r,
      children: [
        CustomIconBadgeWidget(
          icon: icon,
          size: CustomIconBadgeSize.compact,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _compact ? 3.0.r : 4.0.r,
            children: [
              CustomText(
                label,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: context.colors.mutedForeground,
                height: _compact ? null : 1.67,
                isTranslatable: false,
              ),
              content,
            ],
          ),
        ),
      ],
    );

    if (_compact) {
      return row;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.paddingSymmetric(vertical: 16),
          child: row,
        ),
        if (hasBottomDivider) Divider(height: 1, thickness: 1, color: context.colors.borderColor),
      ],
    );
  }
}
