part of '../../ui.dart';

/// Shared portrait footer for multi-step forms (Previous + Next/Submit).
class CustomFormStepFooter extends StatelessWidget {
  final bool showPrevious;
  final VoidCallback? onPrevious;
  final String primaryTitle;
  final VoidCallback? onPrimary;
  final bool isPrimaryLoading;
  final bool isLastStep;
  final bool showCheckOnLastStep;

  const CustomFormStepFooter({
    super.key,
    required this.showPrevious,
    required this.onPrevious,
    required this.primaryTitle,
    required this.onPrimary,
    this.isPrimaryLoading = false,
    this.isLastStep = false,
    this.showCheckOnLastStep = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: context.width,
      padding: context.paddingSymmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: colors.bgMuted50),
      child: SafeArea(
        top: false,
        child: Row(
          spacing: 8,
          children: [
            if (showPrevious)
              Expanded(
                child: ActionButton.outlined(
                  title: AppTrans.previous,
                  onPressed: onPrevious,
                  backgroundColor: colors.cardColor,
                  foregroundColor: colors.primary,
                  borderColor: AppColors.primaryPalette.primary200,
                  borderRadius: 12.radius,
                  padding: context.paddingSymmetric(horizontal: 12, vertical: 8),
                  constraints: BoxConstraints.tightFor(height: 48.r),
                  icon: IconInfo.icon(Icons.arrow_back).buildIconWidget(
                    size: 16.r,
                    color: colors.primary,
                  ),
                  isIconPositionLeft: true,
                  iconSpace: 4,
                  textStyle: context.styles.bodyMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.71,
                    color: colors.primary,
                  ),
                ),
              ),
            Expanded(
              child: ActionButton.primary(
                title: primaryTitle,
                onPressed: onPrimary,
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
                borderRadius: 12.radius,
                padding: context.paddingSymmetric(horizontal: 12, vertical: 8),
                constraints: BoxConstraints.tightFor(height: 48.r),
                isLoading: isPrimaryLoading,
                trailingIcon: isLastStep && showCheckOnLastStep
                    ? IconInfo.icon(Icons.check).buildIconWidget(
                        size: 16.r,
                        color: colors.onPrimary,
                      )
                    : IconInfo.icon(Icons.arrow_forward).buildIconWidget(
                        size: 16.r,
                        color: colors.onPrimary,
                      ),
                iconSpace: 4,
                textStyle: context.styles.bodyMedium.copyWith(
                  fontSize: 14.sp,
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w600,
                  height: 1.71,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
