part of '../../imports/splash_imports.dart';

class BuildSplashAppTitleWidget extends StatelessWidget {
  const BuildSplashAppTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        AppTrans.appName,
        fontSize: 30,
      ),
    );
  }
}
