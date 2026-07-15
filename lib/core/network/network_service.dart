import 'package:dio/dio.dart';

class NetworkService {
  final Dio _dio;

  NetworkService({required Dio dio}) : _dio = dio;

  Future<T> get<T>({
    required String endpoint,
    required T Function(dynamic json) mapper,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(
      endpoint,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      return mapper(response.data);
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Request failed: ${response.statusCode}',
    );
  }
}
