part of '../../imports/register_imports.dart';

class BuildRegisterWithEmailWidget extends StatelessWidget {
  const BuildRegisterWithEmailWidget();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surface,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildRegisterTitleWidget(),
          BuildRegisterNameFieldWidget(),
          BuildRegisterEmailFieldWidget(),
          BuildRegisterPasswordFieldWidget(),
          BuildRegisterConfirmPasswordWidget(),
          BuildRegisterTermsAndConditionsWidget(),
          BuildRegisterButtonWidget(),
        ],
      ),
    );
  }
}
