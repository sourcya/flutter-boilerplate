part of '../../imports/register_imports.dart';

class BuildRegisterButtonWidget extends GetView<RegisterController> {
  const BuildRegisterButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomElevatedButton(
        onPressed: controller.isFormValid.value ? controller.register : null,
        padding: EdgeInsets.symmetric(
          vertical: 17.r,
          horizontal: 8.r,
        ),
        child: CustomText(
          AppTrans.registerText,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: controller.isFormValid.value
              ? context.colors.onPrimary
              : context.colors.subtitleTextColor,
        ),
      );
    });
  }
}
