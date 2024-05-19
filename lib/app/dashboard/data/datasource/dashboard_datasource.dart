class DashboardDatasource {
  static final DashboardDatasource _instance = DashboardDatasource._internal();

  factory DashboardDatasource() {
    return _instance;
  }

  DashboardDatasource._internal();
}
