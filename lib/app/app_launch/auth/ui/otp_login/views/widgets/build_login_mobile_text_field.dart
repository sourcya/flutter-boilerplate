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
              AppTrans.phoneNumberLabel.tr(context: context),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: CustomTextField(
              // label: AppTrans.phoneNumberLabel.tr,
              hint: AppTrans.phoneNumberHint.tr(context: context),
              controller: controller.phoneController,
              type: TextInputType.phone,
              scrollPadding:
                  EdgeInsets.symmetric(vertical: context.height * .3),
              autoFillHints: const [AutofillHints.telephoneNumber],
              validator: qValidator([
                IsRequired(
                  AppTrans.mobileNumberRequiredErrMsg.tr(context: context),
                ),
                IsNumber(AppTrans.validNumberErrMsg.tr(context: context)),
                MinLength(
                  10,
                  AppTrans.validNumberMinLength.tr(context: context),
                ),
              ]),
              errorMaxLines: 2,
              prefixIcon: Icons.phone,
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
