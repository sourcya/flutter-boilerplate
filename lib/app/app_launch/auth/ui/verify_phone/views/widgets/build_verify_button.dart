part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyButton extends GetView<VerifyPhoneController> {
  const BuildVerifyButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: Obx(() {
        return CustomElevatedButton(
          label: AppTrans.verifyPhoneBtnText,
          onPressed: controller.isOtpValid.value ? controller.verifyOtp : null,
          isLoading: controller.isLoading.value,
        );
      }),
    );
  }
}
