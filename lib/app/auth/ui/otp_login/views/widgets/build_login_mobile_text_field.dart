part of '../../imports/login_view_imports.dart';

class BuildMobileLoginTextField extends GetView<OtpLoginController> {


  const BuildMobileLoginTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: CustomTextField(
        label: AppTrans.phoneNumberLabel.tr,
        hint: AppTrans.phoneNumberHint.tr,
        controller: controller.phoneController,
        type: TextInputType.phone,
        // contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        // scrollPadding: EdgeInsets.symmetric(vertical: context.height *.3),
        // autoFillHints: const [
        //   AutofillHints.telephoneNumber
        // ],
        validator: qValidator([
          IsRequired(AppTrans.mobileNumberRequiredErrMsg.tr),
          IsEgyptianPhone(AppTrans.validNumberErrMsg.tr),
        ]),
        prefix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w,),
          child: Icon(
            Icons.phone,
            color: colorScheme.secondary,
            size: 20.r,
          ),
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.isPhoneNumberValid.value = isValid;
        },
      ),
    );
  }

}
