import 'package:flutter_boilerplate/core/models/page_info.dart';

class DataWrapper<T> {
  final T data;
  final PageInfo? pagination;

  DataWrapper({
    required this.data,
    this.pagination,
  });
}
