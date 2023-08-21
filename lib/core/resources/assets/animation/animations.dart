
 class Animations  {
  static final Animations _instance =
  Animations._internal();

  factory Animations() {
   return _instance;
  }

  Animations._internal();



   final String loginAnimation = "assets/animation/login.json";
  final String registerAnimation = "assets/animation/register.json";
  final String noDataAnimation = 'assets/animation/no_data.json';
  final String noInternetAnimation = 'assets/animation/no_internet.json';

  final String firstBoardingAnimation = "assets/animation/first_boarding.json";
  final String secondBoardingAnimation = "assets/animation/second_boarding.json";
  final String thirdBoardingAnimation = "assets/animation/third_boarding.json";
  final String otpAnimation = 'assets/animation/otp-verification.json';

}
