part of '../ui.dart';

Future<bool> showConfirmDeleteDialog({
  required BuildContext context,
  required String title,
  String? confirmLabel,
  String? cancelLabel,
  bool isConfirm = false,
  String? infoMessage,
  VoidCallback? onCancel,
  VoidCallback? onConfirm,
  String? suffixMsg,
  String? message,
  String? permanentMessage,
  String? warningMessage,
  bool hideConfirm = false,
  bool primaryOutlinedCancel = false,
}) {
  return _showCompactDialog(
    context: context,
    title: title.tr(context: context),
    prompt: message?.tr(context: context),
    infoMessage: infoMessage?.tr(context: context),
    confirmLabel: confirmLabel ?? AppTrans.delete,
    cancelLabel: cancelLabel,
    isDestructive: !isConfirm,
    onConfirm: onConfirm ?? () {},
    onCancel: onCancel,
    suffixMsg: suffixMsg,
    trailingMessage: permanentMessage?.tr(context: context),
    warningMessage: warningMessage?.tr(context: context),
    hideConfirm: hideConfirm,
    primaryOutlinedCancel: primaryOutlinedCancel,
  );
}

Future<bool> showLogoutConfirmDialog({
  BuildContext? context,
  VoidCallback? onCancel,
}) {
  final dialogContext = context ?? NavigationUtils.navigationContext;

  return _showCompactDialog(
    context: dialogContext,
    title: AppTrans.logout,
    prompt: dialogContext != null
        ? AppTrans.logoutDialogTitle.tr(context: dialogContext)
        : AppTrans.logoutDialogTitle.tr(),
    warningMessage: dialogContext != null
        ? AppTrans.logoutDialogMessage.tr(context: dialogContext)
        : AppTrans.logoutDialogMessage.tr(),
    confirmLabel: AppTrans.logout,
    cancelLabel: AppTrans.cancel,
    onConfirm: () {},
    onCancel: onCancel,
    forceDialog: true,
    hideCloseButton: true,
    headerIcon: IconInfo.svg(Asset.icons.icLogout),
  );
}

Future<bool> _showCompactDialog({
  BuildContext? context,
  required String title,
  String? message,
  String? prompt,
  String? infoMessage,
  String? warningMessage,
  required String confirmLabel,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  String? cancelLabel,
  String? suffixMsg,
  String? trailingMessage,
  bool hideConfirm = false,
  bool hideCancel = false,
  bool isDestructive = true,
  bool primaryOutlinedCancel = false,
  bool forceDialog = false,
  bool hideCloseButton = false,
  IconInfo? headerIcon,
  String? lottie,
  Color? lottieBackgroundColor,
  Color? accentColor,
}) async {
  final dialogContext = context ?? NavigationUtils.navigationContext;
  if (dialogContext == null) {
    return true;
  }
  bool isConfirmed = false;

  final content = _CompactDialog(
    title: title,
    message: message,
    prompt: prompt,
    infoMessage: infoMessage,
    warningMessage: warningMessage,
    confirmLabel: confirmLabel,
    cancelLabel: cancelLabel,
    suffixMsg: suffixMsg,
    trailingMessage: trailingMessage,
    hideConfirm: hideConfirm,
    hideCancel: hideCancel,
    isDestructive: isDestructive,
    primaryOutlinedCancel: primaryOutlinedCancel,
    forceDialog: forceDialog,
    hideCloseButton: hideCloseButton,
    headerIcon: headerIcon,
    lottie: lottie,
    lottieBackgroundColor: lottieBackgroundColor,
    accentColor: accentColor,
    onConfirm: () {
      isConfirmed = true;
      onConfirm();
    },
    onCancel: () {
      isConfirmed = false;
      onCancel?.call();
    },
  );

  if (!forceDialog && dialogContext.isAppPortrait) {
    await showModalBottomSheet(
      context: dialogContext,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => Align(
        child: Padding(
          padding: dialogContext.paddingAll(16),
          child: content,
        ),
      ),
    );
  } else {
    await showDialog(
      context: dialogContext,
      builder: (_) => Material(
        color: AppColors.transparent,
        child: Dialog(
          insetPadding: dialogContext
              .paddingSymmetric(horizontal: 24, vertical: 20)
              .resolve(Directionality.of(dialogContext)),
          backgroundColor: AppColors.transparent,
          elevation: 0,
          shadowColor: AppColors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: forceDialog && dialogContext.isAppPortrait ? 343.0.r : 696.0.r,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
  return isConfirmed;
}

class _CompactDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String? prompt;
  final String? infoMessage;
  final String? warningMessage;
  final String confirmLabel;
  final String? cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String? suffixMsg;
  final String? trailingMessage;
  final bool hideConfirm;
  final bool hideCancel;
  final bool isDestructive;
  final bool primaryOutlinedCancel;
  final bool forceDialog;
  final bool hideCloseButton;
  final IconInfo? headerIcon;
  final String? lottie;
  final Color? lottieBackgroundColor;
  final Color? accentColor;

  const _CompactDialog({
    required this.title,
    required this.confirmLabel,
    required this.onConfirm,
    required this.onCancel,
    this.message,
    this.prompt,
    this.infoMessage,
    this.warningMessage,
    this.cancelLabel,
    this.suffixMsg,
    this.trailingMessage,
    this.hideConfirm = false,
    this.hideCancel = false,
    this.isDestructive = true,
    this.primaryOutlinedCancel = false,
    this.forceDialog = false,
    this.hideCloseButton = false,
    this.headerIcon,
    this.lottie,
    this.lottieBackgroundColor,
    this.accentColor,
  });

  bool get _hasBodyContent =>
      (message != null && message?.isNotEmpty == true) ||
      (prompt != null && prompt?.isNotEmpty == true) ||
      (suffixMsg != null && suffixMsg?.isNotEmpty == true) ||
      (trailingMessage != null && trailingMessage?.isNotEmpty == true) ||
      (warningMessage != null && warningMessage?.isNotEmpty == true) ||
      (infoMessage != null && infoMessage?.isNotEmpty == true);

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isAppPortrait;
    final isBottomSheet = isPortrait && !forceDialog;
    final headerColor =
        accentColor ?? (isDestructive ? AppColors.semanticDestructive : context.colors.primary);
    final hasBody = _hasBodyContent;
    final hasLottie = lottie != null && lottie?.isNotEmpty == true;

    return Container(
      clipBehavior: Clip.antiAlias,
      padding: isPortrait ? context.paddingAll(16) : null,
      decoration: ShapeDecoration(
        color: context.colors.cardColor,
        shape: RoundedRectangleBorder(
          side: isPortrait ? BorderSide.none : BorderSide(color: context.colors.border),
          borderRadius: 16.radius,
        ),
        shadows: isBottomSheet ? AppShadows.bottomSheet(context) : AppShadows.drawer(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: isPortrait ? 16.r : 0,
        children: [
          _CompactDialogHeader(
            title: title,
            headerColor: headerColor,
            isDestructive: isDestructive,
            headerIcon: headerIcon,
            hideCloseButton: hideCloseButton,
            onClose: () {
              onCancel();
              Navigator.pop(context);
            },
          ),
          if (hasLottie)
            Padding(
              padding: isPortrait
                  ? context.paddingZero()
                  : context.paddingSymmetric(horizontal: 24),
              child: _CompactDialogLottie(
                lottie: lottie ?? '-',
                backgroundColorOfLottie: lottieBackgroundColor,
                accentColor: headerColor,
              ),
            ),
          if (hasBody)
            _CompactDialogBody(
              message: message,
              prompt: prompt,
              suffixMsg: suffixMsg,
              trailingMessage: trailingMessage,
              warningMessage: warningMessage,
              infoMessage: infoMessage,
            ),
          _CompactDialogActions(
            confirmLabel: confirmLabel,
            cancelLabel: cancelLabel,
            hideConfirm: hideConfirm,
            hideCancel: hideCancel,
            isDestructive: isDestructive,
            primaryOutlinedCancel: primaryOutlinedCancel,
            onCancel: () {
              onCancel();
              Navigator.pop(context);
            },
            onConfirm: () {
              onConfirm();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _CompactDialogHeader extends StatelessWidget {
  final String title;
  final Color headerColor;
  final bool isDestructive;
  final IconInfo? headerIcon;
  final bool hideCloseButton;
  final VoidCallback onClose;

  const _CompactDialogHeader({
    required this.title,
    required this.headerColor,
    required this.isDestructive,
    required this.onClose,
    this.headerIcon,
    this.hideCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isAppPortrait;

    final iconSize = headerIcon != null ? 16.r : (isDestructive ? 12.r : 16.r);

    final iconWidget =
        (headerIcon ??
                (isDestructive ? IconInfo.svg(Asset.icons.icDelete) : IconInfo.icon(Icons.check)))
            .buildIconWidget(
              color: isDestructive ? AppColors.basewhite : context.colors.primaryActionText,
              size: iconSize,
            );

    final icon = Container(
      padding: context.paddingAll(6),
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: 6.0.radius,
      ),
      child: Center(child: iconWidget),
    );

    final titleWidget = CustomText(
      title,
      fontSize: isPortrait ? 18.sp : 24.sp,
      fontWeight: FontWeight.w600,
      color: context.colors.cardForeground,
      height: 1,
      letterSpacing: isPortrait ? -0.45 : -0.60,
    );

    if (isPortrait) {
      return Row(
        spacing: 8.r,
        children: [
          icon,
          Expanded(child: titleWidget),
        ],
      );
    }

    if (hideCloseButton) {
      return Padding(
        padding: context.paddingAll(24),
        child: Row(
          spacing: 8.r,
          children: [
            icon,
            Expanded(child: titleWidget),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: context.paddingAll(24),
            child: Row(
              spacing: 8.r,
              children: [
                icon,
                Expanded(child: titleWidget),
              ],
            ),
          ),
        ),
        Padding(
          padding: context.paddingSymmetric(horizontal: 24),
          child: ActionButton.outlined(
            onPressed: onClose,
            backgroundColor: context.colors.cardColor,
            foregroundColor: context.colors.primary,
            borderRadius: 8.radius,
            borderColor: context.colors.primaryOutlineBorder,
            constraints: BoxConstraints.tightFor(width: 32.r, height: 32.r),
            padding: context.paddingZero(),
            icon: IconInfo.svg(
              Asset.icons.close,
              color: context.colors.primary,
            ).buildIconWidget(size: 16.r),
          ),
        ),
      ],
    );
  }
}

class _CompactDialogLottie extends StatelessWidget {
  final String lottie;
  final Color? backgroundColorOfLottie;
  final Color accentColor;

  const _CompactDialogLottie({
    required this.lottie,
    this.backgroundColorOfLottie,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 180.r,
      decoration: BoxDecoration(
        color: backgroundColorOfLottie ?? accentColor.withValues(alpha: .08),
        borderRadius: 16.0.radius,
      ),
      child: SizedBox(
        height: 120.r,
        child: Lottie.asset(lottie, fit: BoxFit.contain),
      ),
    );
  }
}

class _CompactDialogBody extends StatelessWidget {
  final String? message;
  final String? prompt;
  final String? suffixMsg;
  final String? trailingMessage;
  final String? warningMessage;
  final String? infoMessage;

  const _CompactDialogBody({
    this.message,
    this.prompt,
    this.suffixMsg,
    this.trailingMessage,
    this.warningMessage,
    this.infoMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isAppPortrait;
    final mutedStyle = context.bodyLargeTS.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: context.colors.mutedForeground,
      height: 1.75,
    );
    final nameStyle = context.bodyLargeTS.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: context.colors.cardForeground,
      height: 1.75,
    );

    return Padding(
      padding: isPortrait
          ? EdgeInsets.zero
          : context.paddingSymmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.r,
        children: [
          if (message != null && message!.isNotEmpty)
            CustomText(message ?? AppTrans.na, textStyle: mutedStyle),
          if (prompt != null && prompt!.isNotEmpty && suffixMsg != null && suffixMsg!.isNotEmpty)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: prompt!.endsWith(' ') ? prompt : '$prompt ',
                    style: mutedStyle,
                  ),
                  TextSpan(
                    text: '($suffixMsg)',
                    style: nameStyle,
                  ),
                ],
              ),
            )
          else if (prompt != null && prompt!.isNotEmpty)
            CustomText(
              prompt!,
              isTranslatable: false,
              textStyle: mutedStyle,
            )
          else if (suffixMsg != null && suffixMsg!.isNotEmpty)
            CustomText(
              '($suffixMsg)',
              isTranslatable: false,
              textStyle: nameStyle,
            ),
          if (trailingMessage != null && trailingMessage?.isNotEmpty == true)
            CustomText(trailingMessage ?? AppTrans.na, textStyle: mutedStyle),
          if (warningMessage != null && warningMessage?.isNotEmpty == true)
            Row(
              spacing: 6.r,
              children: [
                IconInfo.svg(
                  Asset.icons.svgIcAlert,
                  size: 16.r,
                  color: AppColors.semanticDestructive,
                ).buildIconWidget(),
                Expanded(
                  child: CustomText(
                    warningMessage ?? AppTrans.na,
                    textStyle: context.bodyLargeTS.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.semanticDestructive,
                      height: 1.67,
                    ),
                  ),
                ),
              ],
            ),
          if (infoMessage != null &&
              infoMessage?.isNotEmpty == true &&
              infoMessage != warningMessage)
            CustomText(infoMessage ?? AppTrans.na, textStyle: mutedStyle),
        ],
      ),
    );
  }
}

class _CompactDialogActions extends StatelessWidget {
  final String confirmLabel;
  final String? cancelLabel;
  final bool hideConfirm;
  final bool hideCancel;
  final bool isDestructive;
  final bool primaryOutlinedCancel;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _CompactDialogActions({
    required this.confirmLabel,
    required this.onCancel,
    required this.onConfirm,
    this.cancelLabel,
    this.hideConfirm = false,
    this.hideCancel = false,
    this.isDestructive = true,
    this.primaryOutlinedCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isAppPortrait;
    final buttonStyle = context.labelLargeTS.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      height: 1.71,
    );
    final buttonConstraints = BoxConstraints(minWidth: 80.r, minHeight: 40.r);
    final buttonPadding = context.paddingSymmetric(horizontal: 12, vertical: 8);

    final cancel = cancelLabel != null
        ? (context.isAppLandscape ? cancelLabel! : AppTrans.goBack)
        : AppTrans.cancel;

    final cancelButton = ActionButton.outlined(
      title: cancel,
      onPressed: onCancel,
      backgroundColor: context.colors.cardColor,
      foregroundColor: primaryOutlinedCancel
          ? context.colors.primary
          : context.colors.cardForeground,
      borderColor: primaryOutlinedCancel
          ? context.colors.primaryOutlineBorder
          : context.colors.border,
      borderRadius: 12.radius,
      padding: buttonPadding,
      constraints: buttonConstraints,
      textStyle: buttonStyle.copyWith(
        color: primaryOutlinedCancel ? context.colors.primary : context.colors.cardForeground,
      ),
    );
    final confirmButton = ActionButton.primary(
      title: confirmLabel,
      onPressed: onConfirm,
      backgroundColor: isDestructive ? AppColors.semanticDestructive : context.colors.primary,
      foregroundColor: context.colors.primaryActionText,
      borderRadius: 12.radius,
      padding: buttonPadding,
      constraints: buttonConstraints,
      textStyle: buttonStyle.copyWith(color: context.colors.primaryActionText),
    );

    final buttons = switch ((hideConfirm, hideCancel)) {
      (true, true) => <Widget>[],
      (true, false) => [cancelButton],
      (false, true) => [confirmButton],
      (false, false) =>
        isPortrait && isDestructive ? [confirmButton, cancelButton] : [cancelButton, confirmButton],
    };

    return SizedBox(
      height: isPortrait ? null : 64.r,
      child: Padding(
        padding: isPortrait ? EdgeInsets.zero : context.paddingOnly(start: 24, end: 24, bottom: 24),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Directionality(
            textDirection: context.isCurrentLocaleEnglish ? TextDirection.ltr : TextDirection.rtl,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.r,
              children: buttons,
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> showConfirmDialog({
  required String title,
  required String message,
  String lottie = "",
  String? infoMessage,
  required VoidCallback onConfirmed,
  VoidCallback? onCancel,
  bool hideCancel = false,
  String? confirmLabel,
  String? cancelLabel,
  bool isConfirm = true,
  BuildContext? context,
  Color? lottieBackgroundColor,
  Color? color,
  bool primaryOutlinedCancel = false,
}) async {
  final dialogContext = context ?? NavigationUtils.navigationContext;
  if (dialogContext == null) {
    return true;
  }

  return _showCompactDialog(
    context: dialogContext,
    title: title,
    message: message,
    infoMessage: infoMessage,
    confirmLabel: confirmLabel ?? AppTrans.confirm,
    onCancel: onCancel,
    cancelLabel: cancelLabel,
    onConfirm: onConfirmed,
    hideCancel: hideCancel,
    isDestructive: !isConfirm,
    primaryOutlinedCancel: primaryOutlinedCancel,
    lottie: lottie,
    accentColor: color,
    lottieBackgroundColor: lottieBackgroundColor,
  );
}
