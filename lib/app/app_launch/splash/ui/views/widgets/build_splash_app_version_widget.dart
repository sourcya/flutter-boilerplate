part of '../../imports/splash_imports.dart';

class BuildSplashAppVersionWidget extends StatelessWidget {
  const BuildSplashAppVersionWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      ),
      alignment: Alignment.center,
      child: AppVersion(
        textStyle: TextStyle(
          fontSize: 13,
          // color: context.colors.secondary,
        ),
      ),
    );
  }
}
