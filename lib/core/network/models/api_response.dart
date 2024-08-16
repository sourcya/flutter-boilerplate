import 'package:playx/playx.dart';

import 'api_meta.dart';

class ApiResponse<T> {
  final T data;
  final ApiMeta? meta;

  ApiResponse({
    required this.data,
    this.meta,
  });

  factory ApiResponse.fromJson({
    dynamic json,
    required T Function(dynamic) dataFromJson,
  }) =>
      ApiResponse(
        data: dataFromJson(asMap(json as Map<String, dynamic>, 'data')),
        meta: ApiMeta.fromJson(asMap(json, 'meta')),
      );

  static ApiResponse<List<T>> createApiResponseFromJsonDataList<T>({
    dynamic json,
    required T Function(dynamic) dataFromJson,
  }) {
    final map = json as Map<String, dynamic>;
    final data = asList(map, 'data').map((e) => dataFromJson(e)).toList();

    return ApiResponse(
      data: data,
      meta: ApiMeta.fromJson(asMap(map, 'meta')),
    );
  }

  Map<String, dynamic> toJson({
    required Map<String, dynamic> Function(T data) toDataJson,
  }) =>
      {
        'data': toDataJson(data),
        if (meta != null) 'meta': meta?.toJson(),
      };

  Future<Map<String, dynamic>> toJsonAsync({
    required Future<Map<String, dynamic>> Function(T data) toDataJson,
  }) async =>
      {
        'data': await toDataJson(data),
        if (meta != null) 'meta': meta?.toJson(),
      };

  Map<String, dynamic> toJsonList({
    required List<Map<String, dynamic>> Function(T data) toDataJson,
  }) =>
      {
        'data': toDataJson(data),
        if (meta != null) 'meta': meta?.toJson(),
      };
}
