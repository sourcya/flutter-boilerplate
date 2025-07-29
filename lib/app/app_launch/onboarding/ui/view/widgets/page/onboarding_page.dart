part of '../../../imports/onboarding_imports.dart';

class OnBoardingPage extends StatelessWidget {
  final OnBoarding onboarding;

  const OnBoardingPage({required this.onboarding});

  @override
  Widget build(BuildContext context) {
    return OptimizedScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          onboarding.customWidgetBuilder?.call(context) ??
              Container(
                padding: EdgeInsets.only(right: 8.r, left: 8.r, top: 8.h),
                height: context.height * .48,
                child: Lottie.asset(
                  onboarding.lottieAsset ?? '',
                  errorBuilder: (ctx, e, _) => const SizedBox.shrink(),
                ),
              ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0.r, horizontal: 4.w),
            width: double.infinity,
            child: CustomText(
              onboarding.title,
              textStyle: CustomTextStyles.title(context),
              textAlign: TextAlign.center,
            ),
          ),
          if (onboarding.subtitle?.isNotEmpty == true)
            Container(
              padding: EdgeInsets.all(8.0.r),
              width: double.infinity,
              child: CustomText(
                onboarding.subtitle!,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
