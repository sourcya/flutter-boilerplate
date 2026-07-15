import 'package:boilerplate_ui/core/data_state/request_state.dart';

class DataState<T> {
  final RequestStatus? status;
  final String? error;
  final T? data;

  DataState({
    this.data,
    RequestState? state,
    RequestStatus? status,
    String? error,
  })  : status = state?.status ?? status,
        error = state?.message ?? error;

  const DataState.loading()
      : status = RequestStatus.loading,
        error = null,
        data = null;

  const DataState.success(this.data)
      : status = RequestStatus.success,
        error = null;

  const DataState.failure(this.error)
      : status = RequestStatus.failure,
        data = null;

  bool get isError => status == RequestStatus.failure;
  bool get isLoading => status == RequestStatus.loading;
  bool get isSuccess =>
      status == RequestStatus.success || (data != null && !isError);
  bool get isEmpty => !hasData;

  bool get hasData {
    final value = data;
    if (value == null) return false;
    if (value is Iterable) return value.isNotEmpty;
    if (value is Map) return value.isNotEmpty;
    if (value is String) return value.isNotEmpty;
    return true;
  }
}
