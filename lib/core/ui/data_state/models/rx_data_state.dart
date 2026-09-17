part of '../../ui.dart';

class RxDataState<T> extends Rx<DataState<T>> {
  RxDataState(super.initial);

  RxDataState.initial() : super(const DataState.initial());

  RxDataState.loading() : super(const DataState.loading());

  RxDataState.error(DataError error) : super(DataState.error(error));

  RxDataState.success(T data) : super(DataState.success(data));

  RxDataState<T> copyWith(DataState<T> dataState) {
    value = dataState;
    return this;
  }

  void setLoading() {
    value = const DataState.loading();
  }

  void setError(DataError error) {
    value = DataState.error(error);
  }

  void setNetworkError(NetworkException error) {
    value = DataState.error(DataError.fromNetworkError(error));
  }

  void setSuccess(T data) {
    value = DataState.success(data);
  }

  void setInitial() {
    value = const DataState.initial();
  }

  bool get isLoading => value is Loading<T>;
  bool get isSuccess => value is Success<T>;
  bool get isError => value is Failure<T>;
  bool get isInitial => value is Initial<T>;
}
