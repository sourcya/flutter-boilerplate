class Animations {
  static final Animations _instance = Animations._internal();

  factory Animations() {
    return _instance;
  }

  Animations._internal();

  final String loginAnimation = "assets/animation/login.json";
  final String registerAnimation = "assets/animation/register.json";
  final String noDataAnimation = 'assets/animation/no_data.json';
  final String noInternetAnimation = 'assets/animation/no_internet.json';
  final String error = 'assets/animation/error.json';

  final String firstBoardingAnimation = "assets/animation/boarding.json";
  final String secondBoardingAnimation = "assets/animation/boarding.json";
  final String thirdBoardingAnimation = "assets/animation/boarding.json";
  final String boardingAnimation = "assets/animation/boarding.json";

  final String otpAnimation = 'assets/animation/otp-verification.json';
  final String loading = 'assets/animation/loading.json';

  final String closeApp = 'assets/animation/close_app.json';
  final String delete = 'assets/animation/delete.json';
  final String forgotPassword = 'assets/animation/forgot-password.json';
  final String language = 'assets/animation/language.json';
  final String noConnection = 'assets/animation/no-connection.json';
  final String resetPasswords = 'assets/animation/reset-passwords.json';
  final String reset = 'assets/animation/reset.json';
  final String subscriptionExpired =
      'assets/animation/subscription_expired.json';
  final String theme = 'assets/animation/theme.json';
  final String update = 'assets/animation/update.json';

  String get logout => 'assets/animation/logout.json';

  String get support => 'assets/animation/support.json';
}
