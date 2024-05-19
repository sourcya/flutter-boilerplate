part of '../../imports/splash_imports.dart';

class BuildSplashAppTitleWidget extends StatelessWidget {
  const BuildSplashAppTitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(
        AppTrans.appName,
        fontSize: 30,
      ),
    );
  }
}
