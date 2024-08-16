class Images {
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();

  final String apple = 'assets/images/apple.svg';
  final String google = 'assets/images/google.svg';

  final String placeholder = 'assets/images/placeholder.svg';
  final String profilePlaceholder = 'assets/images/profile_placeholder.svg';
}
