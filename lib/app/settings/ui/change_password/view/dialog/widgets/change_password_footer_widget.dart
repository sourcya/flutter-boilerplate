part of '../../../imports/change_password_imports.dart';

class ChangePasswordFooterWidget extends StatelessWidget {
  final ChangePasswordController controller;
  final EdgeInsetsGeometry padding;
  final bool expanded;
  final double? height;
  final bool isWideLayout;
  final bool alignEnd;

  const ChangePasswordFooterWidget({
    super.key,
    required this.controller,
    required this.padding,
    this.expanded = false,
    this.height,
    this.isWideLayout = false,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonRadius = isWideLayout ? 12.0.radius : 9999.0.radius;

    final cancelButton = ActionButton.outlined(
      title: AppTrans.cancel,
      onPressed: () => Navigator.of(context).pop(),
      backgroundColor: isWideLayout ? context.colors.screenCardSurface : AppColors.transparent,
      foregroundColor: context.colors.primary,
      borderColor: AppColors.primaryPalette.primary200,
      padding: context.paddingSymmetric(horizontal: 12.0, vertical: 8.0),
      borderRadius: buttonRadius,
      constraints: expanded
          ? BoxConstraints.tightFor(height: 40.r)
          : BoxConstraints(minHeight: 40.r, minWidth: 80.r),
      textStyle: context.labelLargeTS.copyWith(
        color: context.colors.primary,
        fontWeight: FontWeight.w600,
        height: 1.71,
      ),
    );

    final saveButton = Obx(() {
      final isEnabled = controller.isFormValid.value;
      final isLoading = controller.isLoading.value;
      return ActionButton.primary(
        title: AppTrans.save,
        onPressed: isEnabled
            ? () async {
                await controller.resetPassword();
              }
            : null,
        isLoading: isLoading,
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.primaryActionText,
        disabledBackgroundColor: context.colors.primary.withValues(alpha: 0.5),
        padding: context.paddingSymmetric(horizontal: 12.0, vertical: 8.0),
        borderRadius: buttonRadius,
        constraints: expanded
            ? BoxConstraints.tightFor(height: 40.r)
            : BoxConstraints(minHeight: 40.r, minWidth: 80.r),
        textStyle: context.labelLargeTS.copyWith(
          color: context.colors.primaryActionText,
          fontWeight: FontWeight.w600,
          height: 1.71,
        ),
      );
    });

    final rowChildren = expanded
        ? [
            Expanded(child: cancelButton),
            8.wBox,
            Expanded(child: saveButton),
          ]
        : [
            cancelButton,
            8.wBox,
            saveButton,
          ];

    if (height != null) {
      return SizedBox(
        height: height,
        child: Padding(
          padding: padding,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: rowChildren,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: (isWideLayout || alignEnd)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: rowChildren,
      ),
    );
  }
}
