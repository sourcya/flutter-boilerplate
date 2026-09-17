part of '../../ui.dart';

/// Settings list row: icon chip, title, primary value pill, and chevron (Figma mobile).
class SettingsPickerRow extends StatelessWidget {
  const SettingsPickerRow({
    super.key,
    required this.title,
    required this.valueLabel,
    required this.onTap,
    this.icon,
    this.svgIcon,
    this.showDivider = false,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
  });

  final String title;
  final String valueLabel;
  final VoidCallback onTap;
  final IconData? icon;
  final String? svgIcon;
  final bool showDivider;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasIcon = icon != null || (svgIcon != null && svgIcon?.isNotEmpty == true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: context.paddingSymmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                children: [
                  if (hasIcon) ...[
                    Container(
                      padding: context.paddingAll(6),
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: 8.0.radius,
                      ),
                      child: IconInfo(
                        icon: icon,
                        svgIcon: svgIcon ?? '',
                        size: 16.r,
                        color: colors.primary,
                      ).buildIconWidget(),
                    ),
                    8.wBox,
                  ],
                  Expanded(
                    child: CustomText(
                      title,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      color: colors.cardForeground,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: context.paddingSymmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.settingsChipSurface,
                          borderRadius: 9999.0.radius,
                        ),
                        child: CustomText(
                          valueLabel,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.33,
                          color: colors.primary,
                        ),
                      ),
                      4.wBox,
                      IconInfo.icon(
                        Icons.chevron_right,
                        size: 20.r,
                        color: colors.cardForeground,
                      ).buildIconWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: colors.cardBorderColor,
            indent: 16.r,
            endIndent: 16.r,
          ),
      ],
    );
  }
}
