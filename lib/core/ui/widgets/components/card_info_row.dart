part of '../../ui.dart';

/// Horizontal label/value row for cards (label start, value end, [MainAxisAlignment.spaceBetween]).
class CardInfoRow extends StatelessWidget {
  const CardInfoRow({
    super.key,
    required this.label,
    this.value,
    this.trailing,
    this.valueSelectable = false,
  }) : assert(value != null || trailing != null);

  final String label;
  final String? value;
  final Widget? trailing;
  final bool valueSelectable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          color: context.colors.mutedForeground,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          font: fontFamilyBasedOnText(label),
        ),
        6.wBox,
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child:
                trailing ??
                CustomText(
                  value ?? '',
                  color: context.colors.cardForeground,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  isSelectable: valueSelectable,
                  font: fontFamilyBasedOnText(value),
                ),
          ),
        ),
      ],
    );
  }
}

/// Pill-style value used for plate numbers on vehicle cards and tables.
class CardInfoPlateChip extends StatelessWidget {
  const CardInfoPlateChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(horizontal: 10, vertical: 4),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.isDarkMode ? context.colors.surfaceContainerHighest : AppColors.slate200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999.r),
        ),
      ),
      child: CustomText(
        text,
        color: context.colors.cardForeground,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        height: 1.33,
        font: fontFamilyBasedOnText(text),
        isSelectable: true,
        isTranslatable: false,
      ),
    );
  }
}
