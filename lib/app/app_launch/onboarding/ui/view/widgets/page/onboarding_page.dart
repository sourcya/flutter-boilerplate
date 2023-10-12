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
          Container(
            padding: EdgeInsets.only(right: 8.w, left: 8.w, top: 8.h),
            height: context.height * .48,
            child: Lottie.asset(onboarding.lottieAsset),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.w),
            width: double.infinity,
            child: Text(
              onboarding.title,
              style: TextStyle(
                  fontSize: PlayxLocalization.isCurrentLocaleArabic() ? 24.sp : 22.sp,
                  // color: colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (onboarding.subtitle?.isNotEmpty == true)
            Container(
              padding: EdgeInsets.all(8.0.r),
              width: double.infinity,
              child: Text(
                onboarding.subtitle!,
                style:
                    TextStyle(fontSize: 16.sp,
                      // color: colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
