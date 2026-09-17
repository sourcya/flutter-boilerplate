part of '../../imports/login_imports.dart';

class LoginShellWidget extends GetView<LoginController> {
  final bool isWideLayout;

  const LoginShellWidget({
    super.key,
    required this.isWideLayout,
  });

  @override
  Widget build(BuildContext context) {
    return isWideLayout ? const LoginWideLayout() : const LoginBody();
  }
}
