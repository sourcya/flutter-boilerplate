part of '../../imports/login_view_imports.dart';

class BuildLoginButton extends GetView<OtpLoginController> {

  const BuildLoginButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            disabledBackgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            padding: const EdgeInsets.all(8),
          ),
          onPressed: controller.isPhoneNumberValid.value ? controller.login : null,
          child: SizedBox(
            width: context.width * 0.5,
            height: context.height * 0.05,
            child: controller.isLoading.value
                ? CenterLoading(
              color: colorScheme.onSecondary,
            )
                : Center(
              child: Text(
                AppTrans.loginText.tr,
                style: TextStyle(
                  color: colorScheme.onSecondary,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

}
