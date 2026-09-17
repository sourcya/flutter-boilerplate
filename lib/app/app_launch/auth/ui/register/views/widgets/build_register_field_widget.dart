part of '../../imports/register_imports.dart';

class BuildRegisterFieldWidget extends GetView<RegisterController> {
  final String label;
  final Widget textField;

  const BuildRegisterFieldWidget({
    required this.label,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 8, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.paddingSymmetric(horizontal: 4.0),
            child: CustomText(
              label,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
          ),
          textField,
        ],
      ),
    );
  }
}
