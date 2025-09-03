part of '../../ui.dart';

enum StickyActionBarStatus {
  none,
  next,
  confirm,
  disabled,
  retry,
  loading;

  String get label => switch (this) {
        retry => AppTrans.retryText,
        confirm => AppTrans.confirm,
        _ => AppTrans.next,
      };
}

class CustomModal {
  const CustomModal._();

  static Future<void> showModal({
    required BuildContext context,
    required WoltModalSheetPageListBuilder pageListBuilder,
    required ValueNotifier<int> pageIndexNotifier,
    VoidCallback? onModalDismissedWithBarrierTap,
    ValueNotifier<bool>? showModalTopBar,
    WoltModalType Function(BuildContext)? typeBuilder,
  }) {
    return WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      barrierDismissible: false,
      context: context,
      pageListBuilder: (ctx) {
        return pageListBuilder(ctx);
      },
      modalTypeBuilder: typeBuilder ??
          (context) {
            return WoltModalType.dialog();
          },
      enableDrag: false,
      onModalDismissedWithBarrierTap: onModalDismissedWithBarrierTap,
    );
  }

  static Future<void> showPageModal({
    required BuildContext context,
    required SliverWoltModalSheetPage Function(BuildContext context)
        pageBuilder,
    VoidCallback? onModalDismissedWithBarrierTap,
    ValueNotifier<bool>? showModalTopBar,
    bool barrierDismissible = true,
    WoltModalType Function(BuildContext)? typeBuilder,
  }) {
    return WoltModalSheet.show<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      pageListBuilder: (ctx) {
        return [pageBuilder(ctx)];
      },
      modalTypeBuilder: typeBuilder ??
          (context) {
            return context.isLandscape || !AppUtils.isMobile()
                ? WoltModalType.dialog()
                : WoltModalType.bottomSheet();
          },
      onModalDismissedWithBarrierTap: onModalDismissedWithBarrierTap,
      enableDrag: true,
    );
  }

  static SliverWoltModalSheetPage buildCustomModalPage({
    required String title,
    required Widget body,
    bool isSliver = true,
    bool hasSabGradient = true,
    ValueNotifier<bool>? showModalTopBar,
    VoidCallback? onClosePressed,
    VoidCallback? onPreviousPressed,
    String? nextLabel,
    VoidCallback? onNextPressed,
    VoidCallback? onTitlePressed,
    RxBool? showPreviousButton,
    Rx<StickyActionBarStatus>? actionBarStatus,
    required BuildContext context,
    List<Widget> Function(BuildContext)? mainContentSliversBuilder,
    Color? backgroundColor,
    double? navBarHeight,
    Widget? trailingNavBarWidget,
    bool hideOnKeyboardVisible = true,
  }) {
    final showTopBar = showModalTopBar?.value ?? true;

    final modalBody = PopScope(
      canPop: onPreviousPressed == null,
      onPopInvokedWithResult: onPreviousPressed != null
          ? (_, __) {
              onPreviousPressed.call();
            }
          : null,
      child: body,
    );

    return isSliver
        ? SliverWoltModalSheetPage(
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.surface.withValues(alpha: .95),
            backgroundColor: backgroundColor ??
                (AppUtils.isDarkMode()
                    ? context.colors.surface
                    : context.colors.surfaceContainerHigh),
            stickyActionBar: actionBarStatus != null
                ? _buildNextButton(
                    status: actionBarStatus,
                    onPressed: onNextPressed,
                    label: nextLabel,
                    hideOnKeyboardVisible: hideOnKeyboardVisible,
                  )
                : null,
            topBarTitle: BuildModalTitleWidget(
              title: title,
              onTitlePressed: onTitlePressed,
            ),
            navBarHeight: navBarHeight ?? (AppUtils.isMobile() ? 48.r : null),
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
            trailingNavBarWidget: trailingNavBarWidget ??
                (onClosePressed == null
                    ? null
                    : BuildModalCloseButton(
                        onPressed: onClosePressed,
                      )),
            leadingNavBarWidget: onPreviousPressed == null
                ? null
                : BuildModalPreviousButton(
                    onPressed: onPreviousPressed,
                    showPreviousButton: showPreviousButton,
                  ),
            mainContentSliversBuilder: mainContentSliversBuilder ??
                (ctx) => [
                      modalBody,
                      if (actionBarStatus != null && onNextPressed != null)
                        SliverToBoxAdapter(
                          child: Opacity(
                            opacity: 0,
                            child: _buildNextButton(
                              listenToUpdates: false,
                              status: actionBarStatus,
                              onPressed: onNextPressed,
                              label: nextLabel,
                              hideOnKeyboardVisible: hideOnKeyboardVisible,
                            ),
                          ),
                        ),
                    ],
          )
        : WoltModalSheetPage(
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.surface.withValues(alpha: .95),
            backgroundColor: backgroundColor ??
                (AppUtils.isDarkMode()
                    ? context.colors.surface
                    : context.colors.surfaceContainerHigh),
            navBarHeight: navBarHeight ?? (AppUtils.isMobile() ? 48.r : null),
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
            trailingNavBarWidget: trailingNavBarWidget ??
                (onClosePressed == null
                    ? null
                    : BuildModalCloseButton(
                        onPressed: onClosePressed,
                      )),
            stickyActionBar: actionBarStatus != null
                ? _buildNextButton(
                    status: actionBarStatus,
                    onPressed: onNextPressed,
                    label: nextLabel,
                    hideOnKeyboardVisible: hideOnKeyboardVisible,
                  )
                : null,
            topBarTitle: showTopBar
                ? BuildModalTitleWidget(
                    title: title,
                    onTitlePressed: onTitlePressed,
                  )
                : const SizedBox.shrink(),
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
    bool hideOnKeyboardVisible = true,
  }) {
    return BuildModalNextButton(
      listenToUpdates: listenToUpdates,
      status: status,
      onPressed: onPressed,
      label: label,
      hideOnKeyboardVisible: hideOnKeyboardVisible,
    );
  }
}
