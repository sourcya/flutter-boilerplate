
part of '../../imports/register_imports.dart';

class BuildRegisterButtonWidget extends GetView<RegisterController> {

    const BuildRegisterButtonWidget();

    @override
    Widget build(BuildContext context) {
        return      Obx(() {
            return Container(
                margin:  EdgeInsets.symmetric(
                    vertical: 5.h,
                ),
                padding:  EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            colorScheme.secondary,
                        ),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.r,
                                ), // <-- Radius
                            ),
                        ),
                        padding:  MaterialStatePropertyAll(
                            EdgeInsets.all(8.r),
                        ),
                    ),
                    onPressed: controller.register,
                    child: SizedBox(
                        width: context.width * 0.5,
                        height: context.height * 0.05,
                        child: controller.isLoading.value
                            ? CenterLoading(
                            color: colorScheme.onSecondary,
                        )
                            : Center(
                            child: Text(
                                AppTrans.registerText.tr,
                                style: TextStyle(
                                    color: colorScheme.onSecondary,
                                    fontSize: 18.sp,
                                ),
                            ),
                        ),
                    ),
                ),
            );
        });
    }
}
