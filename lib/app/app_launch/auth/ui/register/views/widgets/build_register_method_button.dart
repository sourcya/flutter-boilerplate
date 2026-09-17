part of '../../imports/register_imports.dart';

class BuildRegisterMethodButton extends GetView<RegisterController> {
  final LoginMethod method;

  const BuildRegisterMethodButton({
    required this.method,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 8, vertical: 4),
      child: CustomElevatedButton(
        onPressed: () {
          controller.registerBy(method: method);
        },
        margin: EdgeInsets.zero,
        label: method.loginLabel,
      ),
    );
  }
}
