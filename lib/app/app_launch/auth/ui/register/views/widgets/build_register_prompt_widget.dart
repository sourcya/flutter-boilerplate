part of '../../imports/register_imports.dart';

class BuildRegisterPromptWidget extends StatelessWidget {
  const BuildRegisterPromptWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingOnly(end: 8, start: 8, bottom: 8),
      width: double.infinity,
      child: CustomText(
        AppTrans.loginPrompt,
        textStyle: CustomTextStyles.title(context),
        textAlign: TextAlign.center,
      ),
    );
  }
}
