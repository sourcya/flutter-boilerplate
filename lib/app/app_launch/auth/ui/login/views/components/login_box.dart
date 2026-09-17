part of '../../imports/login_imports.dart';

class LoginBox extends CustomOrientationWidget {
  final Widget child;

  const LoginBox({required this.child});

  @override
  Widget buildPortrait(BuildContext context) {
    final isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    final safeBottom = max(context.mediaQuery.padding.bottom, 16.r);
    final footerBottom = safeBottom;
    final footerHeight = 56.r;
    final fabBottom =
        isKeyboardVisible ? safeBottom : footerBottom + footerHeight + 16.r;
    final paddingBottom = fabBottom + 56.r + 24.r;

    return ColoredBox(
      color: context.colors.bgMuted50,
      child: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: context.paddingSymmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _LoginMobileToolbar(),
                  56.hBox,
                  Expanded(
                    child: OptimizedScrollView(
                      child: Padding(
                        padding: context.paddingOnly(bottom: paddingBottom),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!isKeyboardVisible)
              PositionedDirectional(
                start: 16.0.r,
                end: 16.0.r,
                bottom: footerBottom,
                child: LoginFooter(padding: context.paddingZero()),
              ),
            if (!isKeyboardVisible)
              PositionedDirectional(
                end: 16.0.r,
                bottom: fabBottom,
                child: const ContactSpeedDial(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildLandscape(BuildContext context) {
    return buildPortrait(context);
  }
}

class _LoginMobileToolbar extends StatelessWidget {
  const _LoginMobileToolbar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageViewer.svgAsset(
            Assets.icons.logo,
            height: 48.0.r,
            width: 48.0.r,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginActionButton.language(context: context),
              8.wBox,
              LoginActionButton.theme(context: context),
            ],
          ),
        ],
      ),
    );
  }
}
