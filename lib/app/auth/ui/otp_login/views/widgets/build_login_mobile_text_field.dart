part of '../../imports/login_view_imports.dart';

class BuildMobileLoginTextField extends GetView<OtpLoginController> {


  const BuildMobileLoginTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: CustomText(
          AppTrans.phoneNumberLabel.tr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,

        ),),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: CustomTextField(
              // label: AppTrans.phoneNumberLabel.tr,
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
              prefixIcon:Icons.phone,
              shouldAutoValidate: true,
              onValidationChanged: (isValid) {
                controller.isPhoneNumberValid.value = isValid;
              },
            ),
          ),
        ],
      ),
    );
  }

}
