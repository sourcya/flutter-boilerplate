part of '../../imports/register_imports.dart';

class BuildRegisterBackButton extends GetView<RegisterController> {
  const BuildRegisterBackButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedOpacity(
        opacity:
            controller.currentLoginMethod.value == LoginMethod.email ? 1 : 0,
        duration: const Duration(milliseconds: 500),

        /// Back button
        child: Container(
          width: double.infinity,
          alignment: AlignmentDirectional.centerStart,
          padding: context.paddingSymmetric(vertical: 4, horizontal: 4),
          child: IconButton(
            onPressed: () {
              controller.currentLoginMethod.value = null;
            },
            icon: Icon(
              Icons.adaptive.arrow_back,
              color: context.colors.onSurface,
            ),
          ),
        ),
      );
    });
  }
}
