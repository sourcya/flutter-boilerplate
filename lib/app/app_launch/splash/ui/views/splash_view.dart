part of '../imports/splash_imports.dart';

class SplashView extends CustomOrientationWidget {
  const SplashView({super.isInitialized = true, super.key});

  @override
  Widget? buildWidget(BuildContext context, Widget child) {
    return PlatformScaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(color: AppColors.primaryKey),
        child: child,
      ),
    );
  }

  @override
  Widget buildPortrait(BuildContext context) => const SplashPortraitBody();

  @override
  Widget buildLandscape(BuildContext context) => const SplashLandscapeBody();
}
