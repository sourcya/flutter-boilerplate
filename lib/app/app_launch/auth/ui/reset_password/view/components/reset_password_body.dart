part of '../../imports/reset_password_imports.dart';

class ResetPasswordBody extends GetView<ResetPasswordController> {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResetPasswordBox(
      child: ResetPasswordFormBody(),
    );
  }
}
