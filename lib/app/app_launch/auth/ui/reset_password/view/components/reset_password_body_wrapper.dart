part of '../../imports/reset_password_imports.dart';

class ResetPasswordBodyWrapper extends StatelessWidget {
  final bool isWide;

  const ResetPasswordBodyWrapper({
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
      child: ResetPasswordShell(isWideLayout: isWide),
    );
  }
}
