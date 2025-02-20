class Icons {
  static final Icons _instance = Icons._internal();

  factory Icons() {
    return _instance;
  }

  Icons._internal();

  final String logo = 'assets/icons/logo.svg';
}
