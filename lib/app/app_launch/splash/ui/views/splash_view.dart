part of '../imports/splash_imports.dart';

//splash screen.
class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 5,
            ),
            BuildSplashAppTitleWidget(),
            Spacer(
              flex: 4,
            ),
            BuildSplashAppVersionWidget(),
          ],
        ),
      ),
    );
  }
}
