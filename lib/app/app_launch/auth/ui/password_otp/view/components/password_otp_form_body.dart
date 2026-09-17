part of '../../imports/password_otp_imports.dart';

class PasswordOtpFormBody extends GetView<PasswordOtpController> {
  final bool isWideLayout;

  const PasswordOtpFormBody({
    super.key,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isWideLayout) ...[
            CustomText(
              AppTrans.passwordOtpTitle,
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
              height: 1.20,
              letterSpacing: -0.75,
              color: context.colors.foreground,
            ),
            4.hBox,
            CustomText(
              AppTrans.passwordOtpSubtitle,
              textStyle: context.bodyMediumTS.copyWith(
                color: context.colors.mutedForeground,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
            40.hBox,
          ],
          Obx(() {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: controller.isOtpExpired.value
                  ? const Column(
                      key: ValueKey<String>('otp_expired'),
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PasswordOtpExpiredBanner(),
                      ],
                    )
                  : const Column(
                      key: ValueKey<String>('otp_sent'),
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PasswordOtpSentSection(),
                      ],
                    ),
            );
          }),
          40.hBox,
          const PasswordOtpAction(),
        ],
      ),
    );
  }
}
