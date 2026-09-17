part of '../../imports/onboarding_imports.dart';

class OnboardingSlideToolbarWidget extends StatelessWidget {
  final VoidCallback onSkip;

  const OnboardingSlideToolbarWidget({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0.r,
      child: Padding(
        padding: context.paddingSymmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: ImageViewer.svgAsset(
                Assets.logos.getHorizontalLogo(context.isDarkMode),
                width: 94.0.r,
                height: 28.0.r,
                color: context.colors.primary,
              ),
            ),
            ActionButton(
              title: AppTrans.skip.tr(context: context),
              onPressed: onSkip,
              backgroundColor: AppColors.transparent,
              foregroundColor: context.colors.foreground,
              textStyle: context.bodyLargeTS.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.75,
              ),
              padding: context.paddingSymmetric(horizontal: 8, vertical: 4),
            ),
          ],
        ),
      ),
    );
  }
}
