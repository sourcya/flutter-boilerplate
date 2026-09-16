part of '../../ui.dart';

/// Compact primary checkbox for data tables and selectable list rows.
class AppListCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const AppListCheckbox({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onChanged != null;

    return InkWell(
      onTap: enabled ? () => onChanged!(!value) : null,
      borderRadius: 4.0.radius,
      child: Container(
        width: 16.r,
        height: 16.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: value ? context.colors.primary : AppColors.transparent,
          borderRadius: 4.0.radius,
          border: Border.all(width: 1.0.r, color: context.colors.primary),
        ),
        child: value
            ? IconInfo.icon(Icons.check).buildIconWidget(
                size: 12.r,
                color: context.colors.onPrimary,
              )
            : null,
      ),
    );
  }
}
