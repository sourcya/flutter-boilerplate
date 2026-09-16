part of '../../imports/password_otp_imports.dart';

class PasswordOtpFooter extends StatelessWidget {
  final bool isWideLayout;
  final EdgeInsetsGeometry? padding;

  const PasswordOtpFooter({
    super.key,
    this.isWideLayout = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: isWideLayout ? 70.r : null,
      padding:
          padding ??
          (isWideLayout
              ? context.paddingSymmetric(horizontal: 64)
              : context.paddingSymmetric(vertical: 24)),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(
            isWideLayout ? AppTrans.poweredBy : AppTrans.poweredBy,
            textAlign: TextAlign.center,
            maxLines: 1,
            textStyle: context.bodyMediumTS.copyWith(
              color: context.colors.foreground,
              fontSize: isWideLayout ? 16.sp : 14.sp,
              fontWeight: FontWeight.w400,
              height: isWideLayout ? 1.75 : 1.71,
            ),
          ),
        ),
      ),
    );
  }
}
