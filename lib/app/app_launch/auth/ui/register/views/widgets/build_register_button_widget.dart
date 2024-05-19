part of '../../imports/register_imports.dart';

class BuildRegisterButtonWidget extends GetView<RegisterController> {
  const BuildRegisterButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            // backgroundColor: MaterialStatePropertyAll(
            //     // context.colors.secondary,
            // ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12.r,
                ), // <-- Radius
              ),
            ),
            padding: WidgetStatePropertyAll(
              EdgeInsets.all(8.r),
            ),
          ),
          onPressed: controller.register,
          child: SizedBox(
            width: context.width * 0.5,
            height: context.height * 0.05,
            child: controller.isLoading.value
                ? const CenterLoading(
                    // color: context.colors.onSecondary,
                    )
                : Center(
                    child: CustomText(
                      AppTrans.registerText,
                      fontSize: 18.sp,
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
