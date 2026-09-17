part of '../../imports/splash_imports.dart';

extension SplashPreferencesAnimatedEntry on Widget {
  Widget splashPreferencesAnimatedEntry() {
    return animate(delay: const Duration(milliseconds: 140))
        .fadeIn(
          duration: const Duration(milliseconds: 480),
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.06,
          end: 0,
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 520),
        );
  }
}
