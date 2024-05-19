class DashboardRepository {
  static final DashboardRepository _instance = DashboardRepository._internal();

  factory DashboardRepository() {
    return _instance;
  }

  DashboardRepository._internal();
}
