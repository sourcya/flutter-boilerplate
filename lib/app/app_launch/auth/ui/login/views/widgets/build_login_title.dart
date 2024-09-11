part of '../../imports/login_imports.dart';

class BuildLoginTitleWidget extends GetView<LoginController> {
  const BuildLoginTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              right: 10.w,
              left: 10.w,
              bottom: 10.h,
            ),
            width: double.infinity,
            child: CustomText(
              AppTrans.loginText.tr(context: context),
              fontSize: 40.sp,
            ),
          ),
        ),
        Obx(() {
          if (controller.currentLoginMethod.value == LoginMethod.email) {
            return IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () {
                controller.currentLoginMethod.value = null;
              },
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
