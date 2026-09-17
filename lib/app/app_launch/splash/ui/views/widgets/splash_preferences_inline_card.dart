part of '../../imports/splash_imports.dart';

class SplashPreferencesInlineCard extends StatelessWidget {
  final VoidCallback onContinuePressed;

  const SplashPreferencesInlineCard({
    super.key,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    return PlayxThemeSwitcher(
      builder: (context, _) {
        return Container(
          width: double.infinity,
          padding: context.paddingSymmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: AppShadows.bottomSheet(context),
          ),
          child: SetupCardBody(
            onContinuePressed: onContinuePressed,
          ),
        ).splashPreferencesAnimatedEntry();
      },
    );
  }
}
