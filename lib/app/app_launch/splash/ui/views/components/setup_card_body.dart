part of '../../imports/splash_imports.dart';

class SetupCardBody extends StatelessWidget {
  final VoidCallback onContinuePressed;

  const SetupCardBody({
    super.key,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SetupOptionRow<XLocale>(
              iconPath: Assets.icons.language,
              title: AppTrans.language,
              showBottomBorder: true,
              items: PlayxLocalization.supportedXLocales,
              onItemChanged: (value) {
                if (value == null) return;
                PlayxLocalization.updateTo(value);
              },
              itemLabel: (locale) => locale.name,
              isItemSelected: (locale) =>
                  locale.id == PlayxLocalization.currentXLocale.id,
            ),
            PlayxThemeSwitcher(
              builder: (ctx, _) {
                return SetupOptionRow<XTheme>(
                  iconPath: Assets.icons.theme,
                  title: AppTrans.theme,
                  items: PlayxTheme.supportedThemes,
                  onItemChanged: (selectedTheme) {
                    if (selectedTheme == null) return;
                    PlayxTheme.updateTo(
                      selectedTheme,
                      animation: PlayxThemeClipperAnimation(context: ctx),
                    );
                  },
                  itemLabel: (theme) => theme.shortLabel,
                  isItemSelected: (theme) =>
                      theme.id == PlayxTheme.currentTheme.id,
                );
              },
            ),
          ],
        ),
        24.hBox,
        ActionButton(
          title: AppTrans.continueSetupLabel,
          onPressed: onContinuePressed,
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          padding: context.paddingSymmetric(horizontal: 12, vertical: 8),
          constraints: BoxConstraints(minWidth: 80.0.r, minHeight: 44.0.r),
          borderRadius: 12.radius,
          textStyle: context.bodyMediumTS.copyWith(
            color: context.colors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SetupOptionRow<T> extends StatelessWidget {
  final String iconPath;
  final String title;
  final List<T> items;
  final ValueChanged<T?> onItemChanged;
  final String Function(T item) itemLabel;
  final bool Function(T item) isItemSelected;
  final bool showBottomBorder;

  const SetupOptionRow({
    super.key,
    required this.iconPath,
    required this.title,
    required this.items,
    required this.onItemChanged,
    required this.itemLabel,
    required this.isItemSelected,
    this.showBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final trackColor = context.colors.border;

    final row = SizedBox(
      height: 64.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: Row(
              children: [
                ImageViewer.svgAsset(
                  iconPath,
                  width: 20.0.r,
                  height: 20.0.r,
                  color: context.colors.foreground,
                ),
                8.wBox,
                CustomText(
                  title,
                  color: context.colors.foreground,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 9,
            child: Material(
              borderRadius: 8.0.radius,
              clipBehavior: Clip.hardEdge,
              color: AppColors.transparent,
              child: ToggleSwitch<T>(
                items: items,
                onItemChanged: onItemChanged,
                itemLabel: itemLabel,
                isItemSelected: isItemSelected,
                isCompact: true,
                height: 32.0.r,
                minItemWidth: 80.0.r,
                padding: context.paddingZero(),
                itemPadding: context.paddingZero(),
                itemMargin: context.paddingZero(),
                borderRadius: 8.radius,
                borderColor: AppColors.transparent,
                backgroundColor: trackColor,
                selectedColor: context.colors.primary,
                onSelectedColor: context.colors.onPrimary,
                unselectedColor: trackColor,
                color: context.colors.mutedForeground,
                onUnselectedColor: context.colors.mutedForeground,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (!showBottomBorder) return row;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.border),
        ),
      ),
      child: row,
    );
  }
}
