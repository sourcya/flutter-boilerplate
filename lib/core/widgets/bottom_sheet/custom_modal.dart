import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:playx/playx.dart';

import 'widgets/build_modal_close_button.dart';
import 'widgets/build_modal_next_button.dart';
import 'widgets/build_modal_previous_button.dart';
import 'widgets/build_modal_title_widget.dart';

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
        return context.isLandscape || !AppUtils.isMobile()
            ? WoltModalType.dialog()
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
        return context.isLandscape || !AppUtils.isMobile()
            ? WoltModalType.dialog()
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
  }) {
    final showTopBar = showModalTopBar?.value ?? true;

    Fimber.d('onPreviousPressed :$onPreviousPressed');
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
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.surface.withOpacity(.95),
            stickyActionBar: actionBarStatus != null
                ? _buildNextButton(
                    status: actionBarStatus,
                    onPressed: onNextPressed,
                    label: nextLabel,
                  )
                : null,
            topBarTitle: BuildModalTitleWidget(
              title: title,
              onTitlePressed: onTitlePressed,
            ),
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
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
            mainContentSliversBuilder: (context) {
              return [
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
                      ),
                    ),
                  ),
              ];
            },
          )
        : WoltModalSheetPage(
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.surface.withOpacity(.95),
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
            stickyActionBar: actionBarStatus != null
                ? _buildNextButton(
                    status: actionBarStatus,
                    onPressed: onNextPressed,
                    label: nextLabel,
                  )
                : null,
            topBarTitle: showTopBar
                ? BuildModalTitleWidget(
                    title: title,
                    onTitlePressed: onTitlePressed,
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
