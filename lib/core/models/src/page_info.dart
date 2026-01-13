part of '../models.dart';

class PageInfo {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;
  final bool? hasMore;

  const PageInfo({
    required this.page,
    required this.pageCount,
    required this.pageSize,
    required this.total,
    this.hasMore,
  });

  bool get isLastPage => page >= pageCount || pageCount <= 0;

  int? get nextPage => page == pageCount ? null : page + 1;

  @override
  String toString() {
    return 'PageInfo(page: $page, pageSize: $pageSize, pageCount: $pageCount, total: $total, hasMore: $hasMore)';
  }
}
