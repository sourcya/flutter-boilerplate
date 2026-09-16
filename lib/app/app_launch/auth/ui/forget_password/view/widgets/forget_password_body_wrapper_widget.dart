part of '../../imports/forget_password_imports.dart';

class ForgetPasswordBodyWrapper extends StatelessWidget {
  final bool isWide;

  const ForgetPasswordBodyWrapper({
    super.key,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useSafeArea: false,
      includeAppBar: context.isAppPortrait,
      leading: AppBarLeadingType.back,
      title: '',
      showSupportButton: false,
      backgroundColor: context.colors.background,
      attachPortraitConstraint: !isWide,
      bodyAlignment: Alignment.topCenter,
      child: ForgetPasswordShell(isWideLayout: isWide),
    );
  }
}
