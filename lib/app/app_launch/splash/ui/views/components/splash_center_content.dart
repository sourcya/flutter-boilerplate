part of '../../imports/splash_imports.dart';

/// Logo plus optional inline setup card for wide layouts (tablet / web).
class SplashCenterContent extends GetView<SplashController> {
  final bool showInlineSetupCard;

  const SplashCenterContent({
    super.key,
    required this.showInlineSetupCard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SplashLogoWidget(),
        if (showInlineSetupCard) ...[
          24.hBox,
          Obx(() {
            if (!controller.showAppSetupCard.value) {
              return const SizedBox.shrink();
            }

            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 560.r),
              child: SplashPreferencesBottomSheet(
                onContinuePressed: controller.handleOnContinueTap,
              ),
            );
          }),
        ],
      ],
    );
  }
}
