part of '../../ui.dart';

/// Settings list row: icon chip, title, and compact switch (Figma mobile map toggles).
class SettingsSwitchRow extends StatelessWidget {
  const SettingsSwitchRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.icon,
    this.svgIcon,
    this.showDivider = false,
    this.horizontalPadding = 16,
    this.verticalPadding = 16,
    this.titleHeight = 1.0,
    this.onTap,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;
  final String? svgIcon;
  final bool showDivider;
  final double horizontalPadding;
  final double verticalPadding;
  final double titleHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasIcon = icon != null || (svgIcon != null && svgIcon!.isNotEmpty);

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
                        borderRadius: BorderRadius.circular(8.r),
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
                      height: titleHeight,
                      color: colors.cardForeground,
                    ),
                  ),
                  CompactAppSwitch(
                    value: value,
                    onChanged: onChanged,
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
