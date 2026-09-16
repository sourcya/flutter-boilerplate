part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyButton extends GetView<VerifyPhoneController> {
  const BuildVerifyButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(horizontal: 10, vertical: 5),
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
