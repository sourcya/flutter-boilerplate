part of '../../../imports/app_imports.dart';

/// Content for the anchored Material profile [showMenu] (tablet / desktop layout, Android,
/// and iOS on non-mobile widths). On iOS phones, [AppController.onUserProfileTap] uses a
/// [CupertinoActionSheet] instead.
class DrawerMaterialProfileMenuContent extends StatelessWidget {
  final BuildContext anchorContext;
  final Widget userHeader;
  final bool isLandscape;

  const DrawerMaterialProfileMenuContent({
    super.key,
    required this.anchorContext,
    required this.userHeader,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (menuCtx) => _DrawerMaterialProfileMenuSurface(
        menuCtx: menuCtx,
        anchorContext: anchorContext,
        userHeader: userHeader,
        isLandscape: isLandscape,
      ),
    );
  }
}
