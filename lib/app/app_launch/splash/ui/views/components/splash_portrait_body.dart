part of '../../imports/splash_imports.dart';

class SplashPortraitBody extends GetView<SplashController> {
  const SplashPortraitBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final showPreferences = controller.showAppSetupCard.value;
      final isCompact = context.width <= Dimens.bigScreenWidthThreshold;

      return Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SplashCenterContent(
                      showInlineSetupCard: showPreferences && !isCompact,
                    ),
                  ),
                ),
                if (!showPreferences || !isCompact)
                  const SplashPoweredByFooter(),
              ],
            ),
          ),
          if (showPreferences && isCompact)
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 0,
              child: SplashPreferencesBottomSheet(
                onContinuePressed: controller.handleOnContinueTap,
              ),
            ),
        ],
      );
    });
  }
}
