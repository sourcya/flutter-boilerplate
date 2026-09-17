part of '../../imports/login_imports.dart';

class LoginPanelTextColumnWidget extends StatelessWidget {
  final LoginOnboardingSlideData page;

  const LoginPanelTextColumnWidget({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          page.titleKey,
          textStyle: context.headlineMediumTS.copyWith(
            fontSize: 36.sp,
            fontWeight: FontWeight.w600,
            height: 1.11,
            letterSpacing: -0.90,
            color: context.colors.foreground,
          ),
        ),
        8.hBox,
        CustomText(
          page.subtitleKey,
          textStyle: context.bodyLargeTS.copyWith(
            color: context.colors.mutedForeground,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }
}
