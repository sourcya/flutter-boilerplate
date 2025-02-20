part of '../../imports/register_imports.dart';

class BuildRegisterPromptWidget extends StatelessWidget {
  const BuildRegisterPromptWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 8.r,
        left: 8.r,
        bottom: 8.r,
      ),
      width: double.infinity,
      child: const CustomText(
        AppTrans.loginPrompt,
        style: CustomTextStyle.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
