import 'package:playx/playx.dart';

import '../../../../../core/network/endpoints/endpoints.dart';
import '../models/api_user.dart';

///This class is responsible of retrieving data from the network.
class RemoteAuthDataSource {
  static final RemoteAuthDataSource _instance =
      RemoteAuthDataSource._internal();

  factory RemoteAuthDataSource() {
    return _instance;
  }

  RemoteAuthDataSource._internal();

  final PlayxNetworkClient client = Get.find<PlayxNetworkClient>();

  Future<NetworkResult<ApiUser>> login({
    required String email,
    required String password,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.login,
      attachCustomHeaders: false,
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
      attachCustomHeaders: false,
      body: {
        'username': email,
        'email': email,
        'password': password,
      },
      fromJson: ApiUser.fromJson,
    );
    return res;
  }

  Future<NetworkResult<ApiUser>> otpLogin({
    required String phoneNumber,
  }) async {
    final res = await client.post<ApiUser>(
      Endpoints.login,
      attachCustomHeaders: false,
      body: {
        'identifier': phoneNumber,
      },
      fromJson: ApiUser.fromJson,
    );
    return res;
  }

  Future<NetworkResult<ApiUser>> verifyOtpCode({required String pin}) {
    return client.post<ApiUser>(
      Endpoints.register,
      attachCustomHeaders: false,
      body: {
        'pin': pin,
      },
      fromJson: ApiUser.fromJson,
    );
  }
}
