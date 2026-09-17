part of '../../imports/password_otp_imports.dart';

class PasswordOtpBox extends CustomOrientationWidget {
  final Widget child;

  const PasswordOtpBox({super.key, required this.child});

  @override
  Widget buildPortrait(BuildContext context) {
    final safeBottom = max(context.mediaQuery.padding.bottom, 0.0);

    return ColoredBox(
      color: context.colors.authPanelBackground,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: context.paddingSymmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              32.hBox,
              Expanded(
                child: OptimizedScrollView(
                  child: child,
                ),
              ),
              Padding(
                padding: context.paddingOnly(bottom: safeBottom),
                child: PasswordOtpFooter(padding: context.paddingZero()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildLandscape(BuildContext context) => buildPortrait(context);
}
