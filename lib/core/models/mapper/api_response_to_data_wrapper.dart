import '../../network/models/api_meta.dart';
import '../../network/models/api_response.dart';
import '../data_wrapper.dart';
import '../page_info.dart';

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
