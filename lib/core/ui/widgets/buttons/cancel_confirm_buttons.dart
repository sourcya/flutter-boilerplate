part of '../../ui.dart';

/// A reusable row of Cancel (outlined) and Confirm/Primary (elevated) buttons,
/// e.g. for form actions or edit pages.
class CancelConfirmButtons extends StatelessWidget {
  final String? cancelLabel;
  final VoidCallback? onCancel;
  final String? primaryLabel;
  final VoidCallback? onPrimary;
  final bool isPrimaryEnabled;
  final bool isLoading;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? spacing;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool isExpanded;
  final EdgeInsetsGeometry? btnPadding;
  final double? btnMinWidth;
  final IconInfo? primaryIcon;

  const CancelConfirmButtons({
    super.key,
    this.cancelLabel,
    this.onCancel,
    this.primaryLabel,
    this.onPrimary,
    this.isPrimaryEnabled = true,
    this.isLoading = false,
    this.margin,
    this.padding,
    this.spacing,
    this.buttonHeight,
    this.buttonWidth,
    this.isExpanded = false,
    this.btnPadding,
    this.btnMinWidth,
    this.primaryIcon,
  });

  @override
  Widget build(BuildContext context) {
    final row = Directionality(
      textDirection: context.isCurrentLocaleEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: isExpanded ? MainAxisAlignment.center : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: spacing ?? 8.r,
          children: [
            _CancelConfirmButtonSlot(
              isExpanded: isExpanded,
              buttonHeight: buttonHeight,
              buttonWidth: buttonWidth,
              child: CustomElevatedButton(
                backgroundColor: context.colors.cardBackgroundColor,
                borderColor: context.colors.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
                margin: context.paddingZero(),
                padding:
                    btnPadding ??
                    (context.isAppLandscape
                        ? context.paddingAll(12)
                        : context.paddingSymmetric(horizontal: 12, vertical: 8)),
                isMaxWidth: isExpanded,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.primary,
                minWidth: btnMinWidth,
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                label: cancelLabel ?? AppTrans.cancel,
              ),
            ),
            _CancelConfirmButtonSlot(
              isExpanded: isExpanded,
              buttonHeight: buttonHeight,
              buttonWidth: buttonWidth,
              child: CustomElevatedButton(
                margin: context.paddingZero(),
                padding:
                    btnPadding ??
                    (context.isAppLandscape
                        ? context.paddingAll(12)
                        : context.paddingSymmetric(horizontal: 12, vertical: 8)),
                isMaxWidth: isExpanded,
                borderRadius: BorderRadius.circular(12.r),
                minWidth: btnMinWidth,
                onPressed: isPrimaryEnabled ? onPrimary : null,
                isLoading: isLoading,
                icon: primaryIcon,
                iconAtStart: false,
                iconSize: 16.r,
                iconSpace: 4.r,
                label: primaryLabel ?? AppTrans.save,
              ),
            ),
          ],
        ),
      ),
    );
    if (padding != null) {
      return Padding(padding: padding!, child: row);
    }
    return row;
  }
}

class _CancelConfirmButtonSlot extends StatelessWidget {
  const _CancelConfirmButtonSlot({
    required this.isExpanded,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.child,
  });

  final bool isExpanded;
  final double? buttonHeight;
  final double? buttonWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sized = SizedBox(
      height: buttonHeight,
      width: isExpanded ? null : buttonWidth,
      child: child,
    );
    return isExpanded ? Expanded(child: sized) : sized;
  }
}
