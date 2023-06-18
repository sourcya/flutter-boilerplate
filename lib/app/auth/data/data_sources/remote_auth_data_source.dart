import 'package:playx/playx.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/endpoints/endpoints.dart';
import '../../../../core/network/models/network_result.dart';
import '../models/api_user.dart';

///This class is responsible of retrieving data from the network.
class RemoteAuthDataSource {
  static final RemoteAuthDataSource _instance =
      RemoteAuthDataSource._internal();

  factory RemoteAuthDataSource() {
    return _instance;
  }

  RemoteAuthDataSource._internal();

  final ApiClient client = Get.find<ApiClient>();

  Future<NetworkResult<ApiUser>> login({
    required String email,
    required String password,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.login,
      attachToken: false,
      body: {
        'identifier': email,
        'password': password,
      },
      fromJson: ApiUser.fromJson,
    );
    return res;
  }

  Future<NetworkResult<ApiUser>> register({
    required String email,
    required String password,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.register,
      attachToken: false,
      body: {
        'username': email,
        'email': email,
        'password': password,
      },
      fromJson: ApiUser.fromJson,
    );
    return res;
  }
}
