part of '../models.dart';

class DataWrapper<T> {
  final T data;
  final PageInfo? pagination;

  DataWrapper({
    required this.data,
    this.pagination,
  });

  bool get isLastPage => pagination?.isLastPage ?? true;
}
