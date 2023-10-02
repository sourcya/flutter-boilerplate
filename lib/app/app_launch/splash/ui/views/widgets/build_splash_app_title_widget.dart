part of '../../imports/splash_imports.dart';

class BuildSplashAppTitleWidget extends StatelessWidget {
  const BuildSplashAppTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppTrans.appName.tr,
        style: TextStyle(
          fontSize: 30,
          // color: colorScheme.onBackground,
        ),
      ),
    );
  }
}
