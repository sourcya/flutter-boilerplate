part of '../../ui.dart';

/// Figma-style mobile bottom sheet: drag handle, icon header, close, option list.
class PickerBottomSheet extends StatelessWidget {
  const PickerBottomSheet({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconInfo icon;
  final String title;
  final Widget child;

  static Future<T?> show<T>({
    required BuildContext context,
    required IconInfo icon,
    required String title,
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => PickerBottomSheet(
        icon: icon,
        title: title,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.pickerSheetBackground,
        borderRadius: BorderRadius.only(
          topLeft: 24.0.radiusCircular,
          topRight: 24.0.radiusCircular,
        ),
        boxShadow: AppShadows.bottomSheet(context),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.r,
              height: 4.r,
              margin: context.paddingSymmetric(vertical: 12),
              decoration: BoxDecoration(
                color: context.colors.mutedForeground,
                borderRadius: 9999.0.radius,
              ),
            ),
            Padding(
              padding: context.paddingSymmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 24.r,
                          height: 24.r,
                          padding: context.paddingAll(6),
                          decoration: ShapeDecoration(
                            color: context.colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: 6.0.radius,
                            ),
                          ),
                          child: icon.buildIconWidget(
                            size: 12.r,
                            color: context.colors.primaryActionText,
                          ),
                        ),
                        8.wBox,
                        Expanded(
                          child: CustomText(
                            title,
                            textStyle: context.displayMediumTS.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: -0.45,
                              color: context.colors.cardForeground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PickerBottomSheetCloseButton(
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: context.paddingOnly(start: 16, top: 24, end: 16, bottom: 12),
              child: child,
            ),
            context.mediaQueryPadding.bottom.hBox,
          ],
        ),
      ),
    );
  }
}

class PickerBottomSheetCloseButton extends StatelessWidget {
  const PickerBottomSheetCloseButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionButton.outlined(
      onPressed: onTap,
      backgroundColor: context.colors.pickerSheetBackground,
      foregroundColor: context.colors.cardForeground,
      borderColor: context.colors.primary,
      borderRadius: 8.0.radius,
      constraints: BoxConstraints.tightFor(
        height: 32.0.r,
        width: 32.0.r,
      ),
      padding: context.paddingAll(8),
      icon: IconInfo.icon(
        Icons.close,
        size: 16.r,
        color: context.colors.primary,
      ).buildIconWidget(),
    );
  }
}

class PickerBottomSheetOption extends StatelessWidget {
  const PickerBottomSheetOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.font,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? font;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: context.paddingOnly(bottom: 8),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: 12.0.radius,
          child: Container(
            width: context.width,
            padding: context.paddingAll(16),
            decoration: ShapeDecoration(
              color: isSelected
                  ? colors.settingsSegmentSelectedFill
                  : colors.pickerSheetOptionSurface,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isSelected ? colors.primary : colors.cardBorderColor,
                ),
                borderRadius: 12.0.radius,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    label,
                    font: font,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: colors.cardForeground,
                  ),
                ),
                Container(
                  width: 20.r,
                  height: 20.r,
                  padding: context.paddingAll(2),
                  decoration: ShapeDecoration(
                    color: isSelected ? colors.primary : AppColors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isSelected ? colors.primary : colors.cardBorderColor,
                      ),
                      borderRadius: 9999.0.radius,
                    ),
                  ),
                  child: isSelected
                      ? IconInfo.icon(
                          Icons.check,
                          size: 14.r,
                          color: colors.primaryActionText,
                        ).buildIconWidget()
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
