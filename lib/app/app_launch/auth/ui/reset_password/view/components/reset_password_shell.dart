part of '../../imports/reset_password_imports.dart';

class ResetPasswordShell extends StatelessWidget {
  final bool isWideLayout;

  const ResetPasswordShell({
    super.key,
    required this.isWideLayout,
  });

  @override
  Widget build(BuildContext context) {
    return isWideLayout ? const ResetPasswordWideLayout() : const ResetPasswordBody();
  }
}
