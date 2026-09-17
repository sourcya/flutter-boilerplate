part of '../../imports/forget_password_imports.dart';

class ForgetPasswordBody extends GetView<ForgetPasswordController> {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const ForgetPasswordBox(
      child: ForgetPasswordFormBody(),
    );
  }
}
