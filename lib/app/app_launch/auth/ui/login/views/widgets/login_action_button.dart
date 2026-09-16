part of '../../imports/login_imports.dart';

class LoginActionButton extends StatelessWidget {
  final Widget _child;

  const LoginActionButton._({super.key, required Widget child}) : _child = child;

  @override
  Widget build(BuildContext context) => _child;

  factory LoginActionButton.language({
    Key? key,
    required BuildContext context,
  }) {
    final currentLocale = PlayxLocalization.isCurrentLocaleArabic()
        ? AppLocaleConfig.englishLocale
        : AppLocaleConfig.arabicLocale;

    return LoginActionButton._(
      key: key,
      child: ActionButton.outlined(
        title: currentLocale.name,
        onPressed: () {
          PlayxLocalization.updateTo(
            currentLocale,
            forceAppUpdate: true,
          );
        },
        backgroundColor: context.colors.actionButtonBackground,
        foregroundColor: context.colors.primary,
        borderColor: context.colors.actionButtonBorder,
        borderWidth: 1.r,
        borderRadius: 12.radius,
        constraints: BoxConstraints(
          minWidth: 64.r,
          minHeight: 36.r,
          maxHeight: 36.r,
        ),
        padding: context.paddingSymmetric(horizontal: 12, vertical: 6),
        isIconPositionLeft: true,
        iconSpace: 4,
        icon: IconInfo.svg(
          Assets.icons.language,
          size: 16.r,
          color: context.colors.primary,
        ).buildIconWidget(),
        textStyle: context.labelLargeTS.copyWith(
          color: context.colors.primary,
          height: 1.71,
          fontFamily: fontFamilyBasedOnText(currentLocale.name),
        ),
        shadows: context.isAppPortrait
            ? AppShadows.surfaceShadow(context.colors.cardShadowColor)
            : null,
      ),
    );
  }

  factory LoginActionButton.theme({
    Key? key,
    required BuildContext context,
  }) {
    return LoginActionButton._(
      key: key,
      child: ActionButton.outlined(
        onPressed: () => PlayxTheme.next(
          animation: PlayxThemeClipperAnimation(context: context),
        ),
        backgroundColor: context.colors.actionButtonBackground,
        foregroundColor: context.colors.primary,
        borderColor: context.colors.actionButtonBorder,
        borderWidth: 1.r,
        borderRadius: 12.radius,
        constraints: BoxConstraints.tightFor(height: 36.r, width: 36.r),
        padding: context.paddingSymmetric(horizontal: 8, vertical: 8),
        icon: IconInfo.svg(
          Assets.icons.theme,
          size: 16.r,
          color: context.colors.primary,
        ).buildIconWidget(),
        shadows: context.isAppPortrait
            ? AppShadows.surfaceShadow(context.colors.cardShadowColor)
            : null,
      ),
    );
  }
}
