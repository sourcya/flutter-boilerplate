import 'package:flutter_boilerplate/core/models/data_wrapper.dart';
import 'package:flutter_boilerplate/core/models/page_info.dart';
import 'package:flutter_boilerplate/core/network/models/api_meta.dart';
import 'package:flutter_boilerplate/core/network/models/api_response.dart';

extension ApiResponseToDataWrapper<T> on ApiResponse<T> {
  DataWrapper<T> toDataWrapper() {
    return DataWrapper<T>(
      data: data,
      pagination: meta?.toPageInfo(),
    );
  }

  DataWrapper<S> toDataWrapperAndMapData<S>({
    required S Function(T data) mapper,
  }) {
    return DataWrapper<S>(
      data: mapper(data),
      pagination: meta?.toPageInfo(),
    );
  }
}

extension ApiMetaToPageInfo on ApiMeta {
  PageInfo toPageInfo() {
    return PageInfo(
      page: pagination.page,
      pageCount: pagination.pageCount,
      pageSize: pagination.pageSize,
      total: pagination.total,
    );
  }
}
