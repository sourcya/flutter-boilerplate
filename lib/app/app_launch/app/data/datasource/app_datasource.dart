import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:playx/playx.dart';

class AppDatasource {
  AppDatasource({PlayxNetworkClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.client;

  final PlayxNetworkClient _apiClient;
}
