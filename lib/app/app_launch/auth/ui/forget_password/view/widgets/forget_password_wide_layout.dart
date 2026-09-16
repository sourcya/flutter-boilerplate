part of '../../imports/forget_password_imports.dart';

class ForgetPasswordWideLayout extends StatelessWidget {
  const ForgetPasswordWideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final pageBackground = context.colors.authPageBackground;

    return ColoredBox(
      color: pageBackground,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 7,
            child: ColoredBox(
              color: pageBackground,
              child: Padding(
                padding: context.paddingOnly(top: 64, bottom: 64, start: 64, end: 48),
                child: const Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: OptimizedScrollView(
                    child: ForgetPasswordHeroPanel(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: ColoredBox(
              color: context.colors.bgMuted40,
              child: Padding(
                padding: context.paddingOnly(top: 20, bottom: 20, end: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: context.paddingAll(16),
                      child: const Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: SupportButton(),
                      ),
                    ),
                    Expanded(
                      child: OptimizedScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            (context.height / 5.0).hBox,
                            Padding(
                              padding: context.paddingSymmetric(horizontal: 44),
                              child: const ForgetPasswordFormBody(isWideLayout: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ForgetPasswordFooter(
                      isWideLayout: true,
                      padding: context.paddingSymmetric(horizontal: 64),
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
