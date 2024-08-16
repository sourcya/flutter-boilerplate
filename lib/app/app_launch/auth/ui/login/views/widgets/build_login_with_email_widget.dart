part of '../../imports/login_imports.dart';

class BuildLoginWithEmailWidget extends StatelessWidget {
  const BuildLoginWithEmailWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BuildLoginEmailFieldWidget(),
        BuildLoginPasswordFieldWidget(),
        BuildLoginButtonWidget(),
        BuildLoginRegisterNowWidget(),
      ],
    );
  }
}
