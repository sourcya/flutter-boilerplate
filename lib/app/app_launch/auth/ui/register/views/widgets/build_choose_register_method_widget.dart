part of '../../imports/register_imports.dart';

class BuildChooseRegisterMethodWidget extends GetView<RegisterController> {
  const BuildChooseRegisterMethodWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BuildRegisterSubtitleWidget(),
        ...List.generate(
          controller.loginMethods.length,
          (i) => BuildRegisterMethodButton(
            method: controller.loginMethods[i],
          ),
        ),
      ],
    );
  }
}
