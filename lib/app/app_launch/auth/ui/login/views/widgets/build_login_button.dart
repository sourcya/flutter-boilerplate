part of '../../imports/login_imports.dart';

class BuildLoginButtonWidget extends GetView<LoginController> {
  const BuildLoginButtonWidget();

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
            // backgroundColor: context.colors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            padding: const EdgeInsets.all(8),
          ),
          onPressed: controller.login,
          child: SizedBox(
            width: context.width * 0.5,
            height: context.height * 0.05,
            child: controller.isLoading.value
                ? const CenterLoading()
                : Center(
                    child: CustomText(
                      AppTrans.loginText,
                      fontSize: 20.sp,
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
