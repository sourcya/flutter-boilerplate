part of '../../../imports/app_imports.dart';

class BuildDrawerUserCardWidget extends StatelessWidget {
  final bool isExpanded;
  final bool isWideWeb;
  final bool showSettings;
  final bool showUserImg;
  const BuildDrawerUserCardWidget({
    super.key,
    required this.isExpanded,
    this.isWideWeb = false,
    this.showSettings = false,
    this.showUserImg = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPortraitDrawer = !isWideWeb && context.isAppPortrait;
    final useLightDrawerChrome = !context.isDarkMode && (isWideWeb || isPortraitDrawer);
    final foregroundColor = useLightDrawerChrome
        ? AppColors.slate.slate700
        : context.colors.foreground;
    final subtitleColor = useLightDrawerChrome
        ? AppColors.slate.slate700.withValues(alpha: 0.7)
        : context.colors.mutedForeground;

    return Container(
      padding: isWideWeb
          ? (isExpanded ? context.paddingAll(8.0) : context.paddingZero())
          : context.paddingOnly(
              top: 8.0,
              bottom: 16,
              start: 16,
              end: 16,
            ),
      margin: isWideWeb ? context.paddingSymmetric(vertical: isExpanded ? 8.0 : 10.0) : null,
      child: Obx(() {
        final user = AppController.instance.currentUser.value;
        final sub = AppController.instance.currentSubscription.value;
        final name = AppController.instance.getUserDisplayName(
          context,
          user: user,
          subscription: sub,
        );
        final email = AppController.instance.getUserDisplayEmail(
          user: user,
          subscription: sub,
        );
        final initials = name.capitalizedInitialChar;

        if (!isExpanded && isWideWeb) {
          return BuildDrawerUserAvatarWidget(
            initials: initials,
            showUserImg: showUserImg,
            imageUrl: user?.image?.url,
            isExpanded: isExpanded,
            isPortraitDrawer: isPortraitDrawer,
          );
        }

        return Container(
          width: isWideWeb && !isExpanded ? 32.r : double.infinity,
          height: isWideWeb && !isExpanded ? 32.r : null,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: 6.0.radius,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: WebSelectionDisabledGestureDetector(
                  onTap: () => AppController.instance.onUserProfileTap(
                    context: context,
                    user: user,
                    sub: sub,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.r,
                    children: [
                      BuildDrawerUserAvatarWidget(
                        initials: initials,
                        showUserImg: showUserImg,
                        imageUrl: user?.image?.url,
                        isPortraitDrawer: isPortraitDrawer,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2.r,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              name,
                              textStyle: context.styles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: foregroundColor,
                              ),
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              isTranslatable: false,
                            ),
                            if (email.isNotEmpty)
                              CustomText(
                                email,
                                textStyle: context.styles.textXs.copyWith(
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                  color: subtitleColor,
                                ),
                                isTranslatable: false,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              8.wBox,
              Builder(
                builder: (_) {
                  if (showSettings) {
                    return WebSelectionDisabledGestureDetector(
                      onTap: () => AppController.instance.handleProfileSettingsTabTap(
                        SettingsTabs.account,
                      ),
                      child: IconInfo.svg(Assets.icons.settings).buildIconWidget(
                        color: context.colors.accentForeground,
                        size: 16.r,
                      ),
                    );
                  }

                  return SizedBox(
                    width: 28.r,
                    height: 28.r,
                    child: WebSelectionDisabledGestureDetector(
                      onTap: () => AppController.instance.toggleDrawer(),
                      child: Container(
                        padding: context.paddingAll(6.0),
                        decoration: ShapeDecoration(
                          color: useLightDrawerChrome
                              ? AppColors.slate.slate100
                              : context.colors.surfaceContainerHigh,
                          shape: RoundedRectangleBorder(
                            borderRadius: 8.0.radius,
                          ),
                        ),
                        child: IconInfo.svg(Assets.icons.closeX).buildIconWidget(
                          color: useLightDrawerChrome
                              ? AppColors.slate.slate700
                              : context.colors.foreground,
                          size: 16.r,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
