import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/translation/app_translations.dart';
import '../../utils/alert.dart';
import '../components/custom_text.dart';

class ConnectionStatusWidget extends StatefulWidget {
  final Widget child;
  final bool enableCheckingInternet;
  final bool retryOnConnectionRestored;
  final VoidCallback? onRetryClicked;
  final FocusNode? focusNode;

  const ConnectionStatusWidget({
    required this.child,
    this.enableCheckingInternet = true,
    this.onRetryClicked,
    this.retryOnConnectionRestored = true,
    this.focusNode,
  });

  @override
  State<ConnectionStatusWidget> createState() => _ConnectionStatusWidgetState();
}

class _ConnectionStatusWidgetState extends State<ConnectionStatusWidget> {
  ConnectionStatusController get controller =>
      Get.find<ConnectionStatusController>();

  Worker? connectionWorker;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableCheckingInternet) {
      return ValueListenableBuilder(
        valueListenable: controller,
        child: widget.child,
        builder: (ctx, status, child) {
          switch (status) {
            case ConnectionStatus.connected:
              hideBanner();
            case ConnectionStatus.disconnected:
              showDisconnectedBanner();
            case ConnectionStatus.connectionRestored:
              showConnectionRestoredBanner();
              if (widget.retryOnConnectionRestored) {
                widget.onRetryClicked?.call();
              }
          }

          return child ?? widget.child;
        },
      );
    }
    return widget.child;
  }

  void hideBanner() {
    Alert.hideBanner();
  }

  void showConnectionRestoredBanner() {
    Alert.showBanner(
      message:
          AppTrans.internetConnectionRestoredBannerMsg.tr(context: context),
      color: Colors.green,
      actions: [
        TextButton(
          onPressed: () {
            hideBanner();
          },
          focusNode: widget.focusNode,
          child: Padding(
            padding: EdgeInsets.all(4.0.r),
            child: CustomText(
              AppTrans.noInternetConnectionDismissBannerMsg,
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  void showDisconnectedBanner() {
    final showRetryButton = widget.onRetryClicked != null;

    Alert.showBanner(
      message: AppTrans.noInternetConnectionBannerMsg.tr(context: context),
      color: Colors.red,
      textAlign: showRetryButton ? TextAlign.start : TextAlign.center,
      actions: [
        if (showRetryButton) ...[
          TextButton(
            onPressed: () {
              widget.onRetryClicked?.call();
            },
            focusNode: widget.focusNode,
            child: Padding(
              padding: EdgeInsets.all(4.0.r),
              child: CustomText(
                AppTrans.refresh,
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ] else ...[
          const SizedBox(),
        ],
      ],
    );
  }

  @override
  void dispose() {
    connectionWorker?.dispose();
    connectionWorker = null;
    super.dispose();
  }
}
