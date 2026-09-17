part of '../../imports/register_imports.dart';

class BuildRegisterTermsWidget extends GetView<RegisterController> {
  const BuildRegisterTermsWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(horizontal: 12, vertical: 4),
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            height: 24.r,
            width: 24.r,
            child: Obx(() {
              return Checkbox(
                value: controller.agreeToTerms.value,
                onChanged: (value) {
                  controller.agreeToTerms.value = value ?? false;
                },
                activeColor: context.colors.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              );
            }),
          ),
          SizedBox(width: 4.r),
          CustomText(
            AppTrans.agreeToTerms,
            fontSize: 14.sp,
            color: context.colors.onSurface,
            fontWeight: FontWeight.w400,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
