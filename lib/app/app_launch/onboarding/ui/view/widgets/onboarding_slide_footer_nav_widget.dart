part of '../../imports/onboarding_imports.dart';

class OnboardingSlideFooterNavWidget extends StatelessWidget {
  final int pageIndex;
  final int totalPages;

  const OnboardingSlideFooterNavWidget({
    super.key,
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.findOrNull<OnBoardingController>();
    if (controller == null) {
      return const SizedBox.shrink();
    }

    final isFirst = pageIndex == 0;
    final isLast = pageIndex == totalPages - 1;
    final nextLabelKey = isLast ? AppTrans.getStarted : AppTrans.next;
    final constraints = BoxConstraints(minWidth: 80.r);
    final primaryStyle = context.labelLargeTS.copyWith(
      color: context.colors.onPrimary,
      height: 1.71,
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    );
    final outlinedStyle = primaryStyle.copyWith(color: context.colors.primary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: isFirst ? 0.5 : 1,
          child: _OnboardingBackButton(
            controller: controller,
            constraints: constraints,
            style: outlinedStyle,
            enabled: !isFirst,
          ),
        ),
        _OnboardingNextButton(
          controller: controller,
          title: nextLabelKey,
          constraints: constraints,
          style: primaryStyle,
          isLast: isLast,
        ),
      ],
    );
  }
}

class _OnboardingNextButton extends StatelessWidget {
  final OnBoardingController controller;
  final String title;
  final BoxConstraints constraints;
  final TextStyle style;
  final bool isLast;

  const _OnboardingNextButton({
    required this.controller,
    required this.title,
    required this.constraints,
    required this.style,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButton.primary(
      title: title,
      onPressed: controller.onNextOrSkip,
      backgroundColor: context.colors.primary,
      foregroundColor: context.colors.onPrimary,
      borderRadius: 12.radius,
      padding: context.paddingSymmetric(horizontal: 24, vertical: 12),
      constraints: constraints,
      textStyle: style,
      iconSpace: 4.r,
      icon: Transform.rotate(
        angle: !isLast && !context.isLtr ? math.pi : 0,
        child: IconInfo.svg(
          isLast ? Assets.icons.icCheck : Assets.icons.icArrowRight,
          color: context.colors.onPrimary,
          size: 16.r,
        ).buildIconWidget(),
      ),
    );
  }
}

class _OnboardingBackButton extends StatelessWidget {
  final OnBoardingController controller;
  final BoxConstraints constraints;
  final TextStyle style;
  final bool enabled;

  const _OnboardingBackButton({
    required this.controller,
    required this.constraints,
    required this.style,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButton.outlined(
      title: AppTrans.back,
      onPressed: enabled ? controller.onPrevious : () {},
      backgroundColor: context.colors.cardColor,
      disabledBackgroundColor: context.colors.cardColor,
      foregroundColor: context.colors.primary,
      borderColor: context.colors.primaryOutlineBorder,
      borderRadius: 12.radius,
      padding: context.paddingSymmetric(horizontal: 24, vertical: 12),
      constraints: constraints,
      textStyle: style,
      iconSpace: 4.r,
      isIconPositionLeft: true,
      icon: Transform.rotate(
        angle: context.isLtr ? math.pi : 0,
        child: IconInfo.svg(
          Assets.icons.icArrowRight,
          size: 16.r,
          color: context.colors.primary,
        ).buildIconWidget(),
      ),
    );
  }
}
