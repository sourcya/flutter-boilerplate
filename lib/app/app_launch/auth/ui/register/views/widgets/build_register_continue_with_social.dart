part of '../../imports/register_imports.dart';

class BuildRegisterContinueWithSocial extends StatelessWidget {
  const BuildRegisterContinueWithSocial();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0.r),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Divider(
              color: context.colors.onSurface,
              height: 1.0,
              thickness: 1.0,
              indent: 8.0,
              endIndent: 8.0,
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
              AppTrans.continueWithSocial,
              color: context.colors.subtitleTextColor,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Divider(
              color: context.colors.onSurface,
              height: 1.0,
              thickness: 1.0,
              indent: 8.0,
              endIndent: 8.0,
            ),
          ),
        ],
      ),
    );
  }
}
