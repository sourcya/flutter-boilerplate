part of '../../imports/login_imports.dart';

class LoginBodyWrapperWidget extends StatelessWidget {
  final bool isWide;

  const LoginBodyWrapperWidget({
    super.key,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useSafeArea: false,
      includeAppBar: false,
      backgroundColor: isWide
          ? context.colors.surface
          : context.colors.authPageBackground,
      attachPortraitConstraint: !isWide,
      child: LoginShellWidget(isWideLayout: isWide),
    );
  }
}
