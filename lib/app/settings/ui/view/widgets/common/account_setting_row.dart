part of '../../../imports/settings_imports.dart';

/// How the right-hand content area is sized (Figma landscape settings rows).
enum AccountSettingRowContentLayout {
  /// Fills remaining row width (e.g. theme selector chips).
  expanded,

  /// Up to 450px wide, full width within cap (dropdowns).
  constrained,

  /// Shrink-wrap to child (e.g. vehicle view segmented control).
  intrinsic,
}

/// Landscape settings row: 350px label, 16px gap, configurable content area.
class AccountSettingRow extends StatelessWidget {
  const AccountSettingRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.content,
    this.contentLayout = AccountSettingRowContentLayout.constrained,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final IconInfo icon;
  final String title;
  final String subtitle;
  final Widget content;
  final AccountSettingRowContentLayout contentLayout;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        SizedBox(
          width: 350.r,
          child: Semantics(
            label: '$title: $subtitle',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    icon.buildIconWidget(
                      size: 20.r,
                      color: context.colors.mutedForeground,
                    ),
                    6.wBox,
                    Expanded(
                      child: CustomText(
                        title,
                        textStyle: context.titleLargeTS.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                          color: context.colors.cardForeground,
                        ),
                      ),
                    ),
                  ],
                ),
                6.hBox,
                CustomText(
                  subtitle,
                  textStyle: context.bodyMediumTS.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                    color: context.colors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ),
        16.wBox,
        switch (contentLayout) {
          AccountSettingRowContentLayout.expanded => Expanded(child: content),
          AccountSettingRowContentLayout.constrained => Flexible(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 450.r),
                child: SizedBox(width: context.width, child: content),
              ),
            ),
          ),
          AccountSettingRowContentLayout.intrinsic => Flexible(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: content,
            ),
          ),
        },
      ],
    );
  }
}
