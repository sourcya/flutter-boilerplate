part of '../imports/splash_imports.dart';

//splash screen.
class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformScaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _BuildSplashLogoWidget()),
            BuildSplashAppTitleWidget(),
            BuildSplashAppVersionWidget(),
          ],
        ),
      ),
    );
  }
}
