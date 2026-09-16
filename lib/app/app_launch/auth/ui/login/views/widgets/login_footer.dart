part of '../../imports/login_imports.dart';

class LoginFooter extends StatelessWidget {
  final bool isWideLayout;
  final EdgeInsetsGeometry? padding;

  const LoginFooter({
    super.key,
    this.isWideLayout = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (context.mediaQuery.viewInsets.bottom > 0) {
      return const SizedBox.shrink();
    }

    final textColor = context.colors.foreground;
    final textStyle = context.bodyMediumTS.copyWith(
      color: textColor,
      fontSize: isWideLayout ? 16.sp : 14.sp,
      fontWeight: FontWeight.w400,
      height: isWideLayout ? 1.55 : 1.45,
    );

    return Container(
      width: context.width,
      height: isWideLayout ? 86.r : null,
      padding: padding ??
          (isWideLayout
              ? context.paddingSymmetric(horizontal: 80)
              : context.paddingSymmetric(vertical: 24)),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                AppTrans.poweredBy,
                textAlign: TextAlign.center,
                maxLines: 1,
                textStyle: textStyle,
              ),
              4.hBox,
              CustomAppVersion(
                showStroke: false,
                color: textColor,
                fontSize: isWideLayout ? 13.sp : 12.sp,
                textStyle: textStyle.copyWith(
                  fontSize: isWideLayout ? 13.sp : 12.sp,
                  color: textColor.withValues(alpha: 0.72),
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
