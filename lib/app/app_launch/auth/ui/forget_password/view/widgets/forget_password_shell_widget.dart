part of '../../imports/forget_password_imports.dart';

class ForgetPasswordShell extends StatelessWidget {
  final bool isWideLayout;

  const ForgetPasswordShell({
    super.key,
    required this.isWideLayout,
  });

  @override
  Widget build(BuildContext context) {
    return isWideLayout ? const ForgetPasswordWideLayout() : const ForgetPasswordBody();
  }
}
