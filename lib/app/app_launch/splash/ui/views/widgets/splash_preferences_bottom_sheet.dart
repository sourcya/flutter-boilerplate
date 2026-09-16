part of '../../imports/splash_imports.dart';

class SplashPreferencesBottomSheet extends CustomOrientationWidget {
  final VoidCallback onContinuePressed;

  const SplashPreferencesBottomSheet({
    super.key,
    required this.onContinuePressed,
  });

  @override
  Widget buildPortrait(BuildContext context) {
    return SplashPreferencesMobileBottomSheet(
      onContinuePressed: onContinuePressed,
    );
  }

  @override
  Widget buildLandscape(BuildContext context) {
    return SplashPreferencesInlineCard(
      onContinuePressed: onContinuePressed,
    );
  }
}
