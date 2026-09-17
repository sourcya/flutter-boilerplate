part of '../../imports/login_imports.dart';

class LoginBody extends GetView<LoginController> {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBox(
      child: LoginFormBody(controller: controller),
    );
  }
}
