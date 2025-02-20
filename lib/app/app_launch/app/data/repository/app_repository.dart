class AppRepository {
  static final AppRepository _instance = AppRepository._internal();

  factory AppRepository() {
    return _instance;
  }

  AppRepository._internal();
}
