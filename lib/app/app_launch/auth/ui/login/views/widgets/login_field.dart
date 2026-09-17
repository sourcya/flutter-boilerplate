part of '../../imports/login_imports.dart';

class LoginField extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isWideLayout;

  const LoginField({
    super.key,
    required this.title,
    required this.child,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          textStyle: context.headlineSmallTS.copyWith(
            color: context.colors.foreground,
            fontSize: 14.sp,
            height: 1.43,
            fontWeight: FontWeight.w600,
          ),
        ),
        (isWideLayout ? 8.0 : 4.0).hBox,
        child,
      ],
    );
  }
}
