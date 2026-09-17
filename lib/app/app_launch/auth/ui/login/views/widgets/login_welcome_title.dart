part of '../../imports/login_imports.dart';

class LoginWelcomeTitle extends StatelessWidget {
  final bool isWideLayout;

  const LoginWelcomeTitle({
    super.key,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isWideLayout) {
      return CustomText(
        AppTrans.welcomeTitle,
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
        height: 1.20,
        letterSpacing: -0.75,
        color: context.colors.foreground,
      );
    }

    final titleStyle = context.displayLargeTS.copyWith(
      fontSize: 36.sp,
      letterSpacing: -0.9,
      height: 1.0,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppTrans.welcomeFirstPart.tr(context: context),
            style: titleStyle.copyWith(color: context.colors.foreground),
          ),
          TextSpan(
            text: AppTrans.welcomeBackSecondPart.tr(context: context),
            style: titleStyle.copyWith(color: context.colors.primary),
          ),
        ],
      ),
    );
  }
}
