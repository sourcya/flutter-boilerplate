part of '../../imports/reset_password_imports.dart';

class ResetPasswordWideLayout extends StatelessWidget {
  const ResetPasswordWideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final radius_ = 24.0.radius;
    final pageBackground = context.colors.authPageBackground;

    return SafeArea(
      child: ColoredBox(
        color: pageBackground,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: context.paddingOnly(top: 64, bottom: 64, start: 64, end: 48),
                child: const Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: OptimizedScrollView(
                    child: ResetPasswordHeroPanel(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: context.paddingOnly(top: 20, bottom: 20, end: 20),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: context.colors.cardColor,
                    shape: RoundedRectangleBorder(borderRadius: radius_),
                  ),
                  child: ClipRRect(
                    borderRadius: radius_,
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
                                  child: const ResetPasswordFormBody(isWideLayout: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ResetPasswordFooter(
                          isWideLayout: true,
                          padding: context.paddingSymmetric(horizontal: 64),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
