part of '../../imports/login_imports.dart';

class BuildChooseLoginMethodWidget extends GetView<LoginController> {
  const BuildChooseLoginMethodWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          controller.loginMethods.length,
          (i) => Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.r),
            child: BuildLoginMethodButton(
              method: controller.loginMethods[i],
            ),
          ),
        ),
        SizedBox(height: 8.r),
        // const BuildLoginRegisterNowWidget(),
      ],
    );
  }
}
