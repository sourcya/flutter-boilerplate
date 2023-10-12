part of '../imports/verify_phone_view_imports.dart';

// login screen widget.
class VerifyPhoneView extends GetView<VerifyPhoneController> {
  const VerifyPhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
              children: [
                const BuildVerifyLottieAnimation(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 10.h),
                      const BuildVerifyPhoneText(),
                      const BuildVerifySubtitleText(),
                      const BuildVerifyOtpField(),
                      SizedBox(height: 14.h),
                      const BuildVerifyCodeNotReceivedWidget(),
                      const BuildVerifyButton(),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
    );
  }
}