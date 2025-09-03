import 'package:flutter_boilerplate/app/dashboard/data/datasource/dashboard_datasource.dart';
import 'package:playx/playx.dart';

class DashboardRepository {
  final DashboardDatasource _dataSource;
  DashboardRepository({
    required DashboardDatasource dataSource,
  }) : _dataSource = dataSource;

  static DashboardRepository get instance => getIt.get<DashboardRepository>();
}
