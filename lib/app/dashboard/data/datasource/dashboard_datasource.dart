import 'package:flutter_boilerplate/app/dashboard/data/model/dashboard.dart';

abstract class DashboardDatasource {
  Future<List<DashboardItem>> fetchItems();
}

class DashboardDatasourceImpl implements DashboardDatasource {
  DashboardDatasourceImpl();

  @override
  Future<List<DashboardItem>> fetchItems() async {
    return const <DashboardItem>[];
  }
}
