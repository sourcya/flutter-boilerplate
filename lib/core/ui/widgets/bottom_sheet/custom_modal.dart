part of '../../ui.dart';

enum StickyActionBarStatus {
  none,
  next,
  confirm,
  disabled,
  retry,
  loading;

  String get label => switch (this) {
    retry => AppTrans.retryText.tr(),
    confirm => AppTrans.confirm.tr(),
    _ => AppTrans.next.tr(),
  };
}

class CustomModal {
  const CustomModal._();

  /// Show only page modal
  static Future<void> showPageModal({
    required BuildContext context,
    required SliverWoltModalSheetPage Function(BuildContext context)
    pageBuilder,
    VoidCallback? onModalDismissedWithBarrierTap,
    ValueNotifier<bool>? showModalTopBar,
    bool barrierDismissible = true,
  }) {
    return WoltModalSheet.show<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      pageListBuilder: (ctx) {
        return [pageBuilder(ctx)];
      },
      modalTypeBuilder: (context) {
        return context.isLandscape || context.isTablet
            ? CustomWoltModalType()
            : WoltModalType.bottomSheet();
      },
      onModalDismissedWithBarrierTap: onModalDismissedWithBarrierTap,
      enableDrag: true,
    );
  }

  static Future<void> showModal({
    required BuildContext context,
    required WoltModalSheetPageListBuilder pageListBuilder,
    required ValueNotifier<int> pageIndexNotifier,
    VoidCallback? onModalDismissedWithBarrierTap,
    ValueNotifier<bool>? showModalTopBar,
  }) {
    return WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      barrierDismissible: true,
      context: context,
      pageListBuilder: (ctx) {
        return pageListBuilder(ctx);
      },
      modalTypeBuilder: (context) {
        return context.isLandscape || context.isTablet
            ? CustomWoltModalType()
            : WoltModalType.bottomSheet();
      },
      enableDrag: true,
      onModalDismissedWithBarrierTap: onModalDismissedWithBarrierTap,
      onModalDismissedWithDrag: onModalDismissedWithBarrierTap,
    );
  }

  static SliverWoltModalSheetPage buildCustomModalPage({
    required String title,
    required Widget body,
    List<Widget> Function(BuildContext)? mainContentSlivers,
    Widget? leading,
    Widget? trailing,
    bool isSliver = true,
    bool hasSabGradient = true,
    ValueNotifier<bool>? showModalTopBar,
    VoidCallback? onClosePressed,
    VoidCallback? onPreviousPressed,
    String? nextLabel,
    VoidCallback? onNextPressed,
    Widget? nextWidget,
    VoidCallback? onTitlePressed,
    RxBool? showPreviousButton,
    Rx<StickyActionBarStatus>? actionBarStatus,
    double? fontSize,
    required BuildContext context,
    bool useSafeArea = true,
  }) {
    final showTopBar = showModalTopBar?.value ?? true;

    final modalBody = onPreviousPressed == null
        ? body
        : PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) {
                return;
              }
              onPreviousPressed();
            },
            child: body,
          );

    return isSliver
        ? SliverWoltModalSheetPage(
            hasSabGradient: false,
            sabGradientColor: context.colors.surface.withValues(alpha: .95),
            backgroundColor: context.colors.cardColor,
            surfaceTintColor: context.colors.cardColor,
            stickyActionBar:
                nextWidget ??
                (actionBarStatus != null
                    ? _buildNextButton(
                        status: actionBarStatus,
                        onPressed: onNextPressed,
                        label: nextLabel,
                      )
                    : null),
            useSafeArea: useSafeArea,
            topBarTitle: showTopBar
                ? BuildModalTitleWidget(
                    title: title,
                    onTitlePressed: onTitlePressed,
                    fontSize: fontSize,
                  )
                : null,
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
            trailingNavBarWidget:
                trailing ??
                (onClosePressed == null
                    ? null
                    : BuildModalCloseButton(
                        onPressed: onClosePressed,
                      )),
            leadingNavBarWidget:
                leading ??
                (onPreviousPressed == null
                    ? null
                    : BuildModalPreviousButton(
                        onPressed: onPreviousPressed,
                        showPreviousButton: showPreviousButton,
                      )),
            mainContentSliversBuilder:
                mainContentSlivers ??
                (context) {
                  return [
                    modalBody,
                    if (actionBarStatus != null && onNextPressed != null)
                      SliverToBoxAdapter(
                        child: Opacity(
                          opacity: 0,
                          child:
                              nextWidget ??
                              _buildNextButton(
                                listenToUpdates: false,
                                status: actionBarStatus,
                                onPressed: onNextPressed,
                                label: nextLabel,
                              ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 8.r,
                      ),
                    ),
                  ];
                },
          )
        : WoltModalSheetPage(
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.surface.withValues(alpha: .95),
            backgroundColor: context.colors.cardColor,
            surfaceTintColor: context.colors.cardColor,
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
            useSafeArea: useSafeArea,
            stickyActionBar:
                nextWidget ??
                (actionBarStatus != null
                    ? _buildNextButton(
                        status: actionBarStatus,
                        onPressed: onNextPressed,
                        label: nextLabel,
                      )
                    : null),
            topBarTitle: showTopBar
                ? BuildModalTitleWidget(
                    title: title,
                    onTitlePressed: onTitlePressed,
                    fontSize: fontSize,
                  )
                : const SizedBox.shrink(),
            trailingNavBarWidget: onClosePressed == null
                ? null
                : BuildModalCloseButton(
                    onPressed: onClosePressed,
                  ),
            leadingNavBarWidget: onPreviousPressed == null
                ? null
                : BuildModalPreviousButton(
                    onPressed: onPreviousPressed,
                    showPreviousButton: showPreviousButton,
                  ),
            child: modalBody,
          );
  }

  static Widget _buildNextButton({
    bool listenToUpdates = true,
    required Rx<StickyActionBarStatus> status,
    VoidCallback? onPressed,
    String? label,
  }) {
    return BuildModalNextButton(
      listenToUpdates: listenToUpdates,
      status: status,
      onPressed: onPressed,
      label: label,
    );
  }
}
