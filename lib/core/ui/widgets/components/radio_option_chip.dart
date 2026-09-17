part of '../../ui.dart';

/// Single selectable chip (150×40) with label and trailing radio indicator.
class RadioOptionChip<T> extends StatelessWidget {
  const RadioOptionChip({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onSelected,
    required this.label,
    this.font,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T> onSelected;
  final String label;
  final String? font;

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => onSelected(value),
          borderRadius: 12.0.radius,
          child: Ink(
            width: 150.0.r,
            height: 40.0.r,
            padding: context.paddingSymmetric(horizontal: 12, vertical: 6),
            decoration: ShapeDecoration(
              color: isSelected ? colors.settingsSegmentSelectedFill : colors.sidePanelInnerSurface,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isSelected ? colors.primaryOutlineBorder : colors.cardBorderColor,
                ),
                borderRadius: 12.0.radius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: context.paddingSymmetric(horizontal: 4),
                    child: CustomText(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      font: font,
                      textStyle: context.bodyMediumTS.copyWith(
                        fontSize: 14.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        height: 1.71,
                        color: isSelected ? colors.primary : colors.foreground,
                      ),
                    ),
                  ),
                ),
                _RadioIndicator(isSelected: isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal row of [RadioOptionChip]s with 8px spacing.
class RadioOptionChips<T> extends StatelessWidget {
  const RadioOptionChips({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.options,
    this.spacing = 8,
  });

  final T? groupValue;
  final ValueChanged<T> onChanged;
  final List<RadioOptionChipData<T>> options;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < options.length; i++) ...[
          if (i > 0) SizedBox(width: spacing.r),
          RadioOptionChip<T>(
            value: options[i].value,
            groupValue: groupValue,
            onSelected: onChanged,
            label: options[i].label,
            font: options[i].font,
          ),
        ],
      ],
    );
  }
}

class RadioOptionChipData<T> {
  const RadioOptionChipData({
    required this.value,
    required this.label,
    this.font,
  });

  final T value;
  final String label;
  final String? font;
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: 16.r,
      height: 16.r,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: colors.sidePanelInnerSurface,
          shape: OvalBorder(
            side: BorderSide(
              color: isSelected ? colors.primary : colors.foreground,
            ),
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: ShapeDecoration(
                    color: colors.primary,
                    shape: const OvalBorder(),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
