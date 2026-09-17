part of '../../../imports/app_imports.dart';

class DrawerProfileLanguagePickerSheet {
  const DrawerProfileLanguagePickerSheet._();

  static Future<void> show(BuildContext context) {
    return PickerBottomSheet.show(
      context: context,
      icon: IconInfo.icon(
        Icons.language,
        color: context.colors.primaryActionText,
      ),
      title: AppTrans.language,
      child: const _DrawerProfileLanguagePickerBody(),
    );
  }
}

class _DrawerProfileLanguagePickerBody extends StatelessWidget {
  const _DrawerProfileLanguagePickerBody();

  @override
  Widget build(BuildContext context) {
    final currentId = PlayxLocalization.currentXLocale.id;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final language in PlayxLocalization.supportedXLocales)
          PickerBottomSheetOption(
            label: language.name,
            isSelected: currentId == language.id,
            font: fontFamilyBasedOnText(language.name),
            onTap: () {
              Navigator.of(context).pop();
              unawaited(
                AppController.instance.handleProfileLanguageApply(
                  language,
                  context,
                ),
              );
            },
          ),
      ],
    );
  }
}

class _DrawerProfileMenuInkRow extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Widget leading;
  final String label;
  final VoidCallback onTap;
  final void Function(VoidCallback action) popThen;

  const _DrawerProfileMenuInkRow({
    required this.menuCtx,
    required this.scale,
    required this.leading,
    required this.label,
    required this.onTap,
    required this.popThen,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () => popThen(onTap),
        borderRadius: BorderRadius.circular(scale.r(4)),
        child: Padding(
          padding: menuCtx.paddingSymmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              SizedBox(width: scale.r(16), height: scale.r(16), child: leading),
              8.wBox,
              Expanded(
                child: CustomText(
                  label,
                  textStyle: menuCtx.styles.bodyMedium.copyWith(
                    color: menuCtx.colors.onSurface,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerProfileCmdkRow extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color cellBg;
  final Widget leading;
  final String title;
  final Widget trailing;

  const _DrawerProfileCmdkRow({
    required this.menuCtx,
    required this.scale,
    required this.cellBg,
    required this.leading,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: scale.r(128)),
      child: Container(
        width: menuCtx.width,
        padding: menuCtx.paddingSymmetric(horizontal: 8, vertical: 6),
        decoration: ShapeDecoration(
          color: cellBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scale.r(4)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: scale.r(16), height: scale.r(16), child: leading),
            8.wBox,
            Expanded(
              flex: 7,
              child: CustomText(
                title,
                textStyle: menuCtx.styles.bodyMedium.copyWith(
                  color: menuCtx.colors.onSurface,
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            8.wBox,
            Expanded(
              flex: 4,
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerProfilePopoverSection extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color cellBg;
  final Color borderColor;
  final Widget child;

  const _DrawerProfilePopoverSection({
    required this.menuCtx,
    required this.scale,
    required this.cellBg,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: menuCtx.width,
      padding: menuCtx.paddingAll(4),
      decoration: BoxDecoration(
        color: cellBg,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: child,
    );
  }
}

class _DrawerProfilePopoverSingleChild extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color cellBg;
  final Color borderColor;
  final Widget child;

  const _DrawerProfilePopoverSingleChild({
    required this.menuCtx,
    required this.scale,
    required this.cellBg,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _DrawerProfilePopoverSection(
      menuCtx: menuCtx,
      scale: scale,
      cellBg: cellBg,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [child],
      ),
    );
  }
}

class _DrawerProfileUserHeaderBlock extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color cellBg;
  final Widget userHeader;

  const _DrawerProfileUserHeaderBlock({
    required this.menuCtx,
    required this.scale,
    required this.cellBg,
    required this.userHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: menuCtx.width,
      padding: menuCtx.paddingAll(4),
      color: cellBg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(scale.r(6)),
            child: Padding(
              padding: menuCtx.paddingAll(8),
              child: userHeader,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerProfileSettingsBody extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color? muted;
  final void Function(VoidCallback action) popThen;

  const _DrawerProfileSettingsBody({
    required this.menuCtx,
    required this.scale,
    required this.muted,
    required this.popThen,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: scale.r(128)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(scale.r(8), scale.r(6), scale.r(8), scale.r(2)),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: CustomText(
                AppTrans.settings,
                textStyle: menuCtx.styles.textXsSemibold.copyWith(
                  color: muted,
                  fontWeight: FontWeight.w600,
                  height: 1.67,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ),
        ),
        ...SettingsTabs.visibleTabs.map(
          (tab) => _DrawerProfileMenuInkRow(
            menuCtx: menuCtx,
            scale: scale,
            leading: IconInfo.svg(tab.iconAsset).buildIconWidget(
              size: scale.r(16),
              color: menuCtx.colors.onSurface,
            ),
            label: tab.title,
            onTap: () => controller.handleProfileSettingsTabTap(tab),
            popThen: popThen,
          ),
        ),
      ],
    );
  }
}

class _DrawerProfileThemeRow extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color cellBg;
  final Color cmdkAccentTrack;
  final EdgeInsetsGeometry segmentTogglePadding;
  final BuildContext anchorContext;
  final void Function(VoidCallback action) popThen;

  const _DrawerProfileThemeRow({
    required this.menuCtx,
    required this.scale,
    required this.cellBg,
    required this.cmdkAccentTrack,
    required this.segmentTogglePadding,
    required this.anchorContext,
    required this.popThen,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    final isDark = menuCtx.isDarkMode;
    final selectedToggleFill = isDark
        ? menuCtx.colors.primary
        : AppColors.primaryPalette.primary950;
    final selectedToggleForeground = isDark ? AppColors.basewhite : menuCtx.colors.onPrimary;

    return _DrawerProfileCmdkRow(
      menuCtx: menuCtx,
      scale: scale,
      cellBg: cellBg,
      leading: ImageViewer.svgAsset(
        Assets.icons.icTheme,
        width: scale.r(16),
        height: scale.r(16),
        color: menuCtx.colors.onSurface,
      ),
      title: AppTrans.darkTheme,
      trailing: PlayxThemeSwitcher(
        builder: (ctx, _) => ToggleSwitch<XTheme>(
          items: PlayxTheme.supportedThemes,
          onItemChanged: (theme) {
            if (theme == null) return;
            popThen(() => controller.handleProfileThemeApply(theme, anchorContext));
          },
          isCompact: true,
          useNewStyle: true,
          showSelectedItemShadow: false,
          height: scale.r(28),
          padding: menuCtx.paddingZero(),
          itemPadding: segmentTogglePadding,
          itemMargin: menuCtx.paddingZero(),
          backgroundColor: cmdkAccentTrack,
          borderColor: AppColors.transparent,
          unselectedColor: AppColors.transparent,
          selectedColor: selectedToggleFill,
          onSelectedColor: selectedToggleForeground,
          borderRadius: BorderRadius.circular(scale.r(6)),
          minItemWidth: scale.r(30),
          itemIconSize: scale.r(14),
          itemLabelBuilder: (theme) {
            if (theme == null) {
              return const SizedBox.shrink();
            }
            final isSelected = theme.id == ctx.xTheme.id;
            final isLight = theme.id == LightTheme.theme.id;
            return IconInfo.svg(
              isLight ? Assets.icons.icLightMode : Assets.icons.icDarkMode,
              color: isSelected ? selectedToggleForeground : menuCtx.colors.onSurface,
              size: scale.r(14),
            ).buildIconWidget();
          },
          itemLabel: (_) => '',
          isItemSelected: (theme) => theme.id == ctx.xTheme.id,
        ),
      ),
    );
  }
}

class _DrawerProfileLanguageRow extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final Color cellBg;
  final Color cmdkAccentTrack;
  final EdgeInsetsGeometry segmentTogglePadding;
  final BuildContext anchorContext;
  final void Function(VoidCallback action) popThen;

  const _DrawerProfileLanguageRow({
    required this.menuCtx,
    required this.scale,
    required this.cellBg,
    required this.cmdkAccentTrack,
    required this.segmentTogglePadding,
    required this.anchorContext,
    required this.popThen,
  });

  AppController get controller => AppController.instance;

  String _shortLabel(XLocale locale) => locale.id == AppLocaleConfig.englishLocale.id ? 'EN' : 'AR';

  @override
  Widget build(BuildContext context) {
    final isDark = menuCtx.isDarkMode;
    final selectedToggleFill = isDark
        ? menuCtx.colors.primary
        : AppColors.primaryPalette.primary950;
    final selectedToggleForeground = isDark ? AppColors.basewhite : menuCtx.colors.onPrimary;

    return _DrawerProfileCmdkRow(
      menuCtx: menuCtx,
      scale: scale,
      cellBg: cellBg,
      leading: ImageViewer.svgAsset(
        Assets.icons.icLanguage,
        width: scale.r(16),
        height: scale.r(16),
        color: menuCtx.colors.onSurface,
      ),
      title: AppTrans.language,
      trailing: ToggleSwitch<XLocale>(
        items: PlayxLocalization.supportedXLocales,
        onItemChanged: (locale) {
          if (locale == null) return;
          popThen(() => controller.handleProfileLanguageApply(locale, anchorContext));
        },
        isCompact: true,
        useNewStyle: true,
        showSelectedItemShadow: false,
        height: scale.r(28),
        padding: menuCtx.paddingZero(),
        itemPadding: segmentTogglePadding,
        itemMargin: menuCtx.paddingZero(),
        backgroundColor: cmdkAccentTrack,
        borderColor: AppColors.transparent,
        unselectedColor: AppColors.transparent,
        selectedColor: selectedToggleFill,
        onSelectedColor: selectedToggleForeground,
        borderRadius: BorderRadius.circular(scale.r(6)),
        minItemWidth: scale.r(30),
        itemIconSize: scale.r(14),
        itemLabelBuilder: (locale) {
          if (locale == null) return const SizedBox.shrink();
          final selected = locale.id == PlayxLocalization.currentXLocale.id;
          return CustomText(
            _shortLabel(locale),
            textStyle: menuCtx.styles.textXs.copyWith(
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              height: 1.33,
              color: selected ? selectedToggleForeground : menuCtx.colors.onSurface,
            ),
            isTranslatable: false,
          );
        },
        itemLabel: (_) => '',
        isItemSelected: (locale) => locale.id == PlayxLocalization.currentXLocale.id,
      ),
    );
  }
}

class _DrawerProfileSupportSection extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final BuildContext anchorContext;
  final void Function(VoidCallback action) popThen;

  const _DrawerProfileSupportSection({
    required this.menuCtx,
    required this.scale,
    required this.anchorContext,
    required this.popThen,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return _DrawerProfileMenuInkRow(
      menuCtx: menuCtx,
      scale: scale,
      leading: ImageViewer.svgAsset(
        Assets.icons.whatsApp,
        width: scale.r(16),
        height: scale.r(16),
        color: menuCtx.colors.onSurface,
      ),
      label: AppTrans.contactSupport,
      onTap: () => controller.navigateToSupport(context: anchorContext),
      popThen: popThen,
    );
  }
}

class _DrawerProfileLogoutSection extends StatelessWidget {
  final BuildContext menuCtx;
  final DrawerScale scale;
  final BuildContext anchorContext;
  final void Function(VoidCallback action) popThen;

  const _DrawerProfileLogoutSection({
    required this.menuCtx,
    required this.scale,
    required this.anchorContext,
    required this.popThen,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: () => popThen(() => controller.handleProfileLogoutTap(anchorContext)),
        borderRadius: BorderRadius.circular(scale.r(4)),
        child: Padding(
          padding: menuCtx.paddingSymmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              SizedBox(
                width: scale.r(16),
                height: scale.r(16),
                child: IconInfo.svg(Asset.icons.icLogout).buildIconWidget(
                  size: scale.r(16),
                  color: menuCtx.colors.error,
                ),
              ),
              8.wBox,
              Expanded(
                child: CustomText(
                  AppTrans.logout,
                  textStyle: menuCtx.styles.bodyMedium.copyWith(
                    color: menuCtx.colors.error,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerMaterialProfileMenuSurface extends StatelessWidget {
  final BuildContext menuCtx;
  final BuildContext anchorContext;
  final Widget userHeader;
  final bool isLandscape;

  const _DrawerMaterialProfileMenuSurface({
    required this.menuCtx,
    required this.anchorContext,
    required this.userHeader,
    required this.isLandscape,
  });

  void _popMenuThen(VoidCallback action) {
    Navigator.of(menuCtx).pop();
    WidgetsBinding.instance.addPostFrameCallback((_) => action());
  }

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale(isLandscape);
    final border = menuCtx.colors.outlineVariant;
    final cellBg = menuCtx.colors.cardColor;
    final muted = menuCtx.colors.subtitleTextColor;
    final cmdkAccentTrack = menuCtx.colors.muted;
    final segmentTogglePadding = menuCtx.paddingAll(6);
    final outerRadius = scale.r(12);
    final innerClipRadius = outerRadius > 1 ? outerRadius - 1 : 0.0;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: scale.r(224), maxWidth: scale.r(280)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerRadius),
          boxShadow: AppShadows.card(menuCtx),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: cellBg,
            borderRadius: BorderRadius.circular(outerRadius),
            border: Border.all(color: border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerClipRadius),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DrawerProfileUserHeaderBlock(
                  menuCtx: menuCtx,
                  scale: scale,
                  cellBg: cellBg,
                  userHeader: userHeader,
                ),
                Divider(color: border, height: 1.0, thickness: 1.0),
                _DrawerProfilePopoverSection(
                  menuCtx: menuCtx,
                  scale: scale,
                  cellBg: cellBg,
                  borderColor: border,
                  child: _DrawerProfileSettingsBody(
                    menuCtx: menuCtx,
                    scale: scale,
                    muted: muted,
                    popThen: _popMenuThen,
                  ),
                ),
                _DrawerProfilePopoverSingleChild(
                  menuCtx: menuCtx,
                  scale: scale,
                  cellBg: cellBg,
                  borderColor: border,
                  child: _DrawerProfileThemeRow(
                    menuCtx: menuCtx,
                    scale: scale,
                    cellBg: cellBg,
                    cmdkAccentTrack: cmdkAccentTrack,
                    segmentTogglePadding: segmentTogglePadding,
                    anchorContext: anchorContext,
                    popThen: _popMenuThen,
                  ),
                ),
                _DrawerProfilePopoverSingleChild(
                  menuCtx: menuCtx,
                  scale: scale,
                  cellBg: cellBg,
                  borderColor: border,
                  child: _DrawerProfileLanguageRow(
                    menuCtx: menuCtx,
                    scale: scale,
                    cellBg: cellBg,
                    cmdkAccentTrack: cmdkAccentTrack,
                    segmentTogglePadding: segmentTogglePadding,
                    anchorContext: anchorContext,
                    popThen: _popMenuThen,
                  ),
                ),
                _DrawerProfilePopoverSingleChild(
                  menuCtx: menuCtx,
                  scale: scale,
                  cellBg: cellBg,
                  borderColor: border,
                  child: _DrawerProfileSupportSection(
                    menuCtx: menuCtx,
                    scale: scale,
                    anchorContext: anchorContext,
                    popThen: _popMenuThen,
                  ),
                ),
                _DrawerProfilePopoverSingleChild(
                  menuCtx: menuCtx,
                  scale: scale,
                  cellBg: cellBg,
                  borderColor: border,
                  child: _DrawerProfileLogoutSection(
                    menuCtx: menuCtx,
                    scale: scale,
                    anchorContext: anchorContext,
                    popThen: _popMenuThen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
