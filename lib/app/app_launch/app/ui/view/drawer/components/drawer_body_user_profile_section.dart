part of '../../../imports/app_imports.dart';

/// Reactive wrapper around [DrawerBodyUserProfile]: subscribes to the current
/// user / subscription on [AppController] and routes the tap to
/// [AppController.onUserProfileTap].
class DrawerBodyUserProfileSection extends StatelessWidget {
  final bool isExpanded;

  const DrawerBodyUserProfileSection({
    super.key,
    required this.isExpanded,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = AppController.instance.currentUser.value;
      final sub = AppController.instance.currentSubscription.value;
      final name = controller.getUserDisplayName(context, user: user, subscription: sub);
      final email = controller.getUserDisplayEmail(user: user, subscription: sub);

      return WebSelectionDisabledGestureDetector(
        onTap: () => controller.onUserProfileTap(context: context, user: user, sub: sub),
        behavior: HitTestBehavior.opaque,
        child: DrawerBodyUserProfile(
          extended: isExpanded,
          name: name,
          email: email,
        ),
      );
    });
  }
}
