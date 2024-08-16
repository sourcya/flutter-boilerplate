class PageInfo {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  const PageInfo({
    required this.page,
    required this.pageCount,
    required this.pageSize,
    required this.total,
  });

  bool get isLastPage => page >= pageSize;
}
