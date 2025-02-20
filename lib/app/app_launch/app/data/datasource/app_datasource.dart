class AppDatasource {
  static final AppDatasource _instance = AppDatasource._internal();

  factory AppDatasource() {
    return _instance;
  }

  AppDatasource._internal();
}
