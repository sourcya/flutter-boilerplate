part of '../../imports/login_imports.dart';

class LoginPanelQrCodesSectionWidget
    extends GetView<OnboardingSlidesCarouselController> {
  const LoginPanelQrCodesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.currentPage.value.clamp(
        0,
        onboardingPages.length - 1,
      );
      final appLinks = onboardingPages[index].appLinks;
      final iosUrl = appLinks?.iosStoreUrl ?? '';
      final playStoreUrl = appLinks?.playStoreUrl ?? '';
      final hasIosUrl = iosUrl.isNotEmpty;
      final hasPlayStoreUrl = playStoreUrl.isNotEmpty;
      final hasStoreLinks = hasIosUrl || hasPlayStoreUrl;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: PlayxPlatform.isWeb
                ? [
                    if (hasIosUrl)
                      LoginPanelQrCardWidget(
                        icon: Icons.apple,
                        platform: AppTrans.ios.tr(context: context),
                        store: AppTrans.appStore.tr(context: context),
                        qrUrl: iosUrl,
                      ),
                    if (hasIosUrl && hasPlayStoreUrl) 16.wBox,
                    if (hasPlayStoreUrl)
                      LoginPanelQrCardWidget(
                        icon: Icons.android,
                        platform: AppTrans.android.tr(context: context),
                        store: AppTrans.googlePlayStore.tr(context: context),
                        qrUrl: playStoreUrl,
                      ),
                  ]
                : [
                    ActionButton.outlined(
                      title: AppTrans.viewWebDashboard.tr(context: context),
                      onPressed: () => launchUrlString(Constants.webUrl),
                      backgroundColor: AppColors.transparent,
                      foregroundColor: context.colors.primary,
                      borderColor: AppColors.primaryPalette.primary200,
                      borderRadius: 9999.radius,
                      isIconPositionLeft: true,
                      icon: IconInfo.svg(
                        Assets.icons.download,
                        size: 16.r,
                        color: context.colors.primary,
                      ).buildIconWidget(),
                      padding: context.paddingSymmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      constraints: BoxConstraints(minWidth: 64.r),
                      textStyle: context.labelLargeTS.copyWith(
                        color: context.colors.primary,
                        fontSize: 14.sp,
                        height: 1.71,
                      ),
                    ),
                  ],
          ),
          if (PlayxPlatform.isWeb && hasStoreLinks) ...[
            24.hBox,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconInfo.svg(
                  Assets.icons.download,
                  size: 16.r,
                  color: context.colors.foreground,
                ).buildIconWidget(),
                8.wBox,
                CustomText(
                  AppTrans.installMobileApp.tr(context: context),
                  textAlign: TextAlign.center,
                  textStyle: context.displayMediumTS.copyWith(
                    color: context.colors.foreground,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    letterSpacing: -0.60,
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    });
  }
}
