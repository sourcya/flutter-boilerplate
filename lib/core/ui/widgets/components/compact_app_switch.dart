part of '../../ui.dart';

/// [AppSwitch] sized for form rows (44×24 track, primary when on).
class CompactAppSwitch extends StatelessWidget {
  final double? width;
  final double? height;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CompactAppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final w = width ?? 44.r;
    final h = height ?? 24.r;
    final thumbSize = h - 4.r;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: w,
        height: h,
        padding: context.paddingAll(2),
        decoration: BoxDecoration(
          color: value ? context.colors.primary : context.colors.muted,
          borderRadius: (h / 2.0).radius,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              color: value
                  ? context.colors.cardBackgroundColor
                  : context.colors.cardBackgroundColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
