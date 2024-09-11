import 'package:playx/playx.dart';

class ApiMeta {
  final Pagination pagination;

  ApiMeta({
    required this.pagination,
  });

  factory ApiMeta.fromJson(Map<String, dynamic>? json) => ApiMeta(
        pagination: Pagination.fromJson(asMap(json, 'pagination')),
      );

  Map<String, dynamic> toJson() => {
        'pagination': pagination.toJson(),
      };
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
    this.page = 0,
    this.pageSize = 0,
    this.pageCount = 0,
    this.total = 0,
  });

  factory Pagination.fromJson(Map<String, dynamic>? json) => Pagination(
        page: asInt(json, 'page'),
        pageSize: asInt(json, 'pageSize'),
        pageCount: asInt(json, 'pageCount'),
        total: asInt(json, 'total'),
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'pageSize': pageSize,
        'pageCount': pageCount,
        'total': total,
      };
}
