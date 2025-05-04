class Images {
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();

  final String placeholder = 'assets/images/placeholder.svg';
  final String profilePlaceholder = 'assets/images/profile_placeholder.svg';
}
