
class Images {
  static final Images _instance =
  Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();

  final String googleLogoImage = 'assets/images/google.svg';

}
