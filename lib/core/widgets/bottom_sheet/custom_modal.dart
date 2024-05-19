import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_colors.dart';
import '../../resources/translation/app_translations.dart';
import '../../utils/app_utils.dart';
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
  }) {
    return WoltModalSheet.show<void>(
      pageIndexNotifier: pageIndexNotifier,
      barrierDismissible: true,
      context: context,
      pageListBuilder: (ctx) {
        return pageListBuilder(ctx);
      },
      modalTypeBuilder: (context) {
        return AppUtils.isMobile()
            ? WoltModalType.bottomSheet
            : WoltModalType.dialog;
      },
      enableDrag: true,
      onModalDismissedWithBarrierTap: onModalDismissedWithBarrierTap,
      useRootNavigator: true,
      minDialogWidth: context.width * 0.9,
      maxDialogWidth: context.width * 0.95,
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
    VoidCallback? onNextPressed,
    RxBool? showPreviousButton,
    Rx<StickyActionBarStatus>? actionBarStatus,
    required BuildContext context,
  }) {
    final showTopBar = showModalTopBar?.value ?? true;
    return isSliver
        ? SliverWoltModalSheetPage(
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.background.withOpacity(.95),
            stickyActionBar: actionBarStatus != null
                ? _buildNextButton(
                    status: actionBarStatus,
                    onPressed: onNextPressed,
                  )
                : null,
            topBarTitle: BuildModalTitleWidget(
              title: title,
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
            mainContentSlivers: [
              body,
              if (actionBarStatus != null && onNextPressed != null)
                SliverToBoxAdapter(
                  child: Opacity(
                    opacity: 0,
                    child: _buildNextButton(
                      listenToUpdates: false,
                      status: actionBarStatus,
                      onPressed: onNextPressed,
                    ),
                  ),
                ),
            ],
          )
        : WoltModalSheetPage(
            hasSabGradient: hasSabGradient,
            sabGradientColor: context.colors.background.withOpacity(.95),
            hasTopBarLayer: showTopBar,
            isTopBarLayerAlwaysVisible: showTopBar,
            stickyActionBar: actionBarStatus != null
                ? _buildNextButton(
                    status: actionBarStatus,
                    onPressed: onNextPressed,
                  )
                : null,
            topBarTitle: showTopBar
                ? BuildModalTitleWidget(
                    title: title,
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
            child: body,
          );
  }

  static Widget _buildNextButton({
    bool listenToUpdates = true,
    required Rx<StickyActionBarStatus> status,
    VoidCallback? onPressed,
  }) {
    return BuildModalNextButton(
      listenToUpdates: listenToUpdates,
      status: status,
      onPressed: onPressed,
    );
  }
}
