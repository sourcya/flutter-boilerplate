part of '../../imports/login_imports.dart';

class BuildLoginMethodButton extends GetView<LoginController> {
  final LoginMethod method;
  const BuildLoginMethodButton({
    required this.method,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.r,
        vertical: 4.r,
      ),
      child: CustomElevatedButton(
        onPressed: () {
          controller.loginBy(method: method);
        },
        margin: EdgeInsets.zero,
        color: context.colors.primary,
        child: Row(
          children: [
            SizedBox(width: 16.r),
            SizedBox(
              width: 20.r,
              height: 20.r,
              child: method.icon.buildIconWidget(
                color: method.iconColor(context),
              ),
            ),
            SizedBox(width: 10.r),
            CustomText(
              method.loginLabel,
              fontSize: 16.sp,
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
