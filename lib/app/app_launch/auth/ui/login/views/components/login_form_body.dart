part of '../../imports/login_imports.dart';

class LoginFormBody extends StatelessWidget {
  const LoginFormBody({
    super.key,
    required this.controller,
    this.isWideLayout = false,
  });

  final LoginController controller;
  final bool isWideLayout;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginWelcomeTitle(isWideLayout: isWideLayout),
          if (isWideLayout) 8.hBox else 4.hBox,
          LoginSubtitle(isWideLayout: isWideLayout),
          40.hBox,
          LoginField(
            title: isWideLayout
                ? AppTrans.emailLabelWideLandscape
                : AppTrans.emailLabel,
            isWideLayout: isWideLayout,
            child: const LoginEmailField(),
          ),
          if (isWideLayout) 24.hBox else 16.hBox,
          LoginField(
            title: AppTrans.passwordLabel,
            isWideLayout: isWideLayout,
            child: const LoginPasswordField(),
          ),
          const LoginRememberMeSection(),
          40.hBox,
          const LoginButton(),
          if (isWideLayout) const HelpSeparator(),
        ],
      ),
    );
  }
}
