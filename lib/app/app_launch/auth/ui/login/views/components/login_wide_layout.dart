part of '../../imports/login_imports.dart';

class LoginWideLayout extends GetView<LoginController> {
  const LoginWideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final pageBackground = context.colors.authPageBackground;

    return ColoredBox(
      color: pageBackground,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 836,
            child: ColoredBox(
              color: pageBackground,
              child: Padding(
                padding: context.paddingAll(80.0),
                child: const LoginOnboardingPanel(),
              ),
            ),
          ),
          Expanded(
            flex: 604,
            child: ColoredBox(
              color: context.colors.bgMuted40,
              child: Padding(
                padding: context.paddingOnly(top: 80, start: 56, end: 56),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 40.0.r,
                  children: [
                    SizedBox(
                      height: 100.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageViewer.svgAsset(
                            Assets.logos.getHorizontalLogo(context.isDarkMode),
                            color: context.colors.authLogoForeground,
                            height: 48.0.r,
                            width: 161.0.r,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 8.0.r,
                            children: [
                              LoginActionButton.language(context: context),
                              LoginActionButton.theme(context: context),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: OptimizedScrollView(
                        child: LoginFormBody(
                          controller: controller,
                          isWideLayout: true,
                        ),
                      ),
                    ),
                    LoginFooter(
                      isWideLayout: true,
                      padding: context.paddingSymmetric(horizontal: 80),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
