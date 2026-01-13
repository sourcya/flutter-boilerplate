part of '../models.dart';

class DataWrapper<T> {
  final T data;
  final PageInfo? pagination;
  final String? message;
  final bool? hasMore;

  const DataWrapper({
    required this.data,
    this.pagination,
    this.message,
    this.hasMore,
  });

  bool get isLastPage => pagination?.isLastPage == true;

  int? get nextPage => pagination?.nextPage;
  DataWrapper<T> copyWith({
    T? data,
    PageInfo? pagination,
    String? message,
    bool? hasMore,
  }) {
    return DataWrapper<T>(
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
      message: message ?? this.message,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  String toString() {
    return 'DataWrapper(pagination: $pagination, message: $message, hasMore: $hasMore,data: $data)';
  }
}
