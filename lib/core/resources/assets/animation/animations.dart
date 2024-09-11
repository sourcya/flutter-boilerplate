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
  final String otpAnimation = 'assets/animation/otp-verification.json';
  final String loading = 'assets/animation/loading.json';
}
