part of '../../../imports/app_imports.dart';

class BuildBottomNavProfileImageWidget extends StatelessWidget {
  const BuildBottomNavProfileImageWidget();

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: PlayxPlatform.isCupertino ? 11 : 14,
      backgroundColor:
          controller.currentBottomNavIndex == controller.bottomNavItems.length
              ? PlayxPlatform.isIOS
                  ? context.colors.primary
                  : context.colors.onSecondaryContainer
              : context.colors.onSurface,
      child: CircleAvatar(
        radius: PlayxPlatform.isCupertino ? 10 : 14,
        backgroundColor: context.colors.surface,
        child: ClipOval(
          child: Obx(() {
            // final imageUrl = controller.userInfo.value?.image?.url ?? '';
            final imageUrl = '';
            if (imageUrl.isEmpty) {
              return PlaceholderImageWidget(
                path: Assets.images.profilePlaceholder,
                padding: EdgeInsets.zero,
              );
            }
            return ImageViewer.cachedNetwork(
              imageUrl,
              errorBuilder: (
                context,
                error,
              ) =>
                  PlaceholderImageWidget(
                path: Assets.images.profilePlaceholder,
                padding: EdgeInsets.zero,
              ),
              placeholderBuilder: (
                context,
              ) =>
                  PlaceholderImageWidget(
                path: Assets.images.profilePlaceholder,
                padding: EdgeInsets.zero,
              ),
            );
          }),
        ),
      ),
    );
  }
}
