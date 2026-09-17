part of '../../imports/splash_imports.dart';

class SplashPreferencesMobileBottomSheet extends StatelessWidget {
  final VoidCallback onContinuePressed;

  const SplashPreferencesMobileBottomSheet({
    super.key,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    return PlayxThemeSwitcher(
      builder: (context, _) {
        return Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            boxShadow: AppShadows.bottomSheet(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: context.paddingSymmetric(horizontal: 16, vertical: 12),
                child: Center(
                  child: Container(
                    width: 48.r,
                    height: 4.r,
                    decoration: ShapeDecoration(
                      color: context.colors.mutedForeground,
                      shape: RoundedRectangleBorder(
                        borderRadius: Style.radius9999,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: context.paddingSymmetric(horizontal: 16, vertical: 12),
                child: SetupCardBody(onContinuePressed: onContinuePressed),
              ),
              context.mediaQuery.padding.bottom.hBox,
            ],
          ),
        ).splashPreferencesAnimatedEntry();
      },
    );
  }
}
