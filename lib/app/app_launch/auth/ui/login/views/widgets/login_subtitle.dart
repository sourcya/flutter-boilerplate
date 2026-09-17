part of '../../imports/login_imports.dart';

class LoginSubtitle extends StatelessWidget {
  final bool isWideLayout;

  const LoginSubtitle({
    super.key,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    final text = isWideLayout
        ? AppTrans.signInAccessSubtitle.tr(context: context)
        : AppTrans.welcomeSubtitle.tr(context: context);
    return CustomText(
      text,
      isTranslatable: false,
      textStyle: isWideLayout
          ? context.bodyLargeTS.copyWith(
              color: context.colors.mutedForeground,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.75,
            )
          : context.bodyMediumTS.copyWith(
              color: context.colors.mutedForeground,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
    );
  }
}
