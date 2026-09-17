part of '../../../imports/settings_imports.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? label;
  final IconData? icon;
  final String? svgIcon;
  final void Function()? onTap;
  final bool? isSelected;
  final void Function(bool)? onSelectionChanged;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final Color? subtitleColor;
  final bool isSubtitleTranslatable;
  final Widget? subtitleWidget;
  final bool showLoadingIndicator;
  final String? actionButtonText;
  final void Function()? onActionButtonTap;
  final bool showDivider;
  final bool showIconBackground;
  final Color? iconBackgroundColor;

  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.label,
    this.icon,
    this.svgIcon,
    required this.onTap,
    this.isSelected,
    this.onSelectionChanged,
    this.padding,
    this.size,
    this.subtitleColor,
    this.isSubtitleTranslatable = true,
    this.subtitleWidget,
    this.showLoadingIndicator = false,
    this.actionButtonText,
    this.onActionButtonTap,
    this.showDivider = false,
    this.showIconBackground = true,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final scheme = colors.colorScheme;
    final borderColor = colors.cardBorderColor;
    final iconBgColor = iconBackgroundColor ?? colors.primaryContainer;
    final iconColor = colors.primary;
    final titleColor = colors.cardForeground;

    late final Color chipBackgroundColor;
    late final Color chipTextColor;
    if (actionButtonText != null &&
        (onActionButtonTap != null || onTap != null)) {
      chipBackgroundColor = colors.primary;
      chipTextColor = colors.primaryActionText;
    } else if (label != null) {
      chipBackgroundColor = colors.primary;
      chipTextColor = colors.onPrimary;
    } else {
      chipBackgroundColor = scheme.secondaryContainer;
      chipTextColor = scheme.onSecondaryContainer;
    }

    final Widget card = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: padding ?? context.paddingSymmetric(vertical: 16),
          child: Row(
            children: [
              if (icon != null || (svgIcon != null && svgIcon!.isNotEmpty))
                Container(
                  padding: context.paddingAll(6),
                  decoration: BoxDecoration(
                    color: showIconBackground
                        ? iconBgColor
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: IconInfo(
                    icon: icon,
                    svgIcon: svgIcon ?? '',
                    color: iconColor,
                    size: size ?? 16.r,
                  ).buildIconWidget(),
                ),
              if (icon != null || (svgIcon != null && svgIcon!.isNotEmpty))
                8.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4.r,
                  children: [
                    if (label != null)
                      CustomText(
                        label ?? '-',
                        color: colors.mutedForeground,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        isTranslatable: isSubtitleTranslatable,
                        height: 1.67,
                      ),
                    CustomText(
                      title,
                      color: titleColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                    ),
                    if (subtitle != null || subtitleWidget != null)
                      subtitleWidget ??
                          CustomText(
                            subtitle!,
                            color: subtitleColor ?? colors.mutedForeground,
                            fontSize: 14.sp,
                            isTranslatable: isSubtitleTranslatable,
                          ),
                  ],
                ),
              ),
              if (actionButtonText != null || onActionButtonTap != null)
                Padding(
                  padding: context.paddingOnly(start: 8),
                  child: ConstrainedBox(
                    constraints: label != null
                        ? BoxConstraints(minWidth: 64.r)
                        : const BoxConstraints(),
                    child: GestureDetector(
                      onTap: onActionButtonTap,
                      child: Container(
                        padding: context.paddingSymmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: chipBackgroundColor,
                          shape: const StadiumBorder(),
                        ),
                        child: CustomText(
                          actionButtonText!,
                          color: chipTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.71,
                        ),
                      ),
                    ),
                  ),
                ),
              if (isSelected != null && actionButtonText == null)
                AppSwitch.themed(
                  context: context,
                  value: isSelected!,
                  onChanged: onSelectionChanged,
                ),
            ],
          ),
        ),
        if (showLoadingIndicator)
          Padding(
            padding: context.paddingSymmetric(horizontal: 8, vertical: 4),
            child: LinearProgressIndicator(color: colors.primary),
          ),
        if (showDivider)
          Divider(height: 1.r, thickness: 1.r, color: borderColor),
      ],
    );

    return onTap != null
        ? CustomInkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: card,
          )
        : card;
  }
}

class BuildSettingsTile extends SettingsTile {
  const BuildSettingsTile({
    super.key,
    required super.title,
    super.subtitle,
    super.icon,
    super.svgIcon,
    required super.onTap,
    super.isSelected,
    super.onSelectionChanged,
    super.padding,
    super.size,
  });
}
