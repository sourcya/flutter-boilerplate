part of '../../imports/forget_password_imports.dart';

class ForgetPasswordHeroPanel extends StatelessWidget {
  const ForgetPasswordHeroPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          40.hBox,
          Center(
            child: Lottie.asset(
              Assets.animations.icForgetPassword,
              height: 448.0.r,
            ),
          ),
          CustomText(
            AppTrans.forgetPasswordText,
            fontSize: 26.sp,
            fontWeight: FontWeight.w600,
            height: 1.12,
            letterSpacing: -0.65,
            color: context.colors.foreground,
          ),
          10.hBox,
          CustomText(
            AppTrans.forgetPasswordSubtitle,
            maxLines: 3,
            textOverflow: TextOverflow.ellipsis,
            textStyle: context.bodyLargeTS.copyWith(
              color: context.colors.mutedForeground,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
