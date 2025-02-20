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
      padding: EdgeInsets.symmetric(
        horizontal: 8.r,
        vertical: 4.r,
      ),
      child: CustomElevatedButton(
        onPressed: () {
          controller.registerBy(method: method);
        },
        margin: EdgeInsets.zero,
        color: context.colors.primary,
        child: Row(
          children: [
            SizedBox(width: 16.r),
            if (method.icon != null)
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: method.icon?.buildIconWidget(
                  color: method.iconColor(context),
                ),
              ),
            SizedBox(width: 10.r),
            CustomText(
              method.loginLabel,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: method.onBackground(context),
            ),
            SizedBox(width: 10.r),
          ],
        ),
      ),
    );
  }
}
