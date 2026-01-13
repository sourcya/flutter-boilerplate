part of '../../ui.dart';

class Initial<T> extends DataState<T> {
  const Initial({super.data, super.error});
}

class Loading<T> extends DataState<T> {
  const Loading({super.data}) : super(error: null);
}

class Success<T> extends DataState<T> {
  const Success(T data) : super(data: data, error: null);
}

class Failure<T> extends DataState<T> {
  const Failure(DataError error) : super(data: null, error: error);
}

class NetworkFailure<T> extends Failure<T> {
  final NetworkException exception;

  NetworkFailure(this.exception) : super(DataError.fromNetworkError(exception));
}

/// Generic Wrapper class for the result of any type.
sealed class DataState<T> {
  final T? data;

  final DataError? error;

  const DataState({this.data, this.error});

  const factory DataState.initial({T? data}) = Initial;

  const factory DataState.loading({T? data}) = Loading;

  const factory DataState.success(T data) = Success;

  const factory DataState.error(DataError error) = Failure;

  factory DataState.fromNetworkResult(NetworkResult<T> result) => result.map(
    success: (success) => Success(success.data),
    error: (error) => NetworkFailure(error.error),
  );

  factory DataState.fromNetworkError(NetworkException error) = NetworkFailure;

  factory DataState.fromEmptyError({String? error}) =>
      Failure(DataError.empty(error: error));

  factory DataState.fromDefaultError({String? error}) =>
      Failure(DataError.error(error: error));

  factory DataState.fromNoInternetError({String? error}) =>
      Failure(DataError.noInternetError(error: error));

  bool get isSuccess => this is Success<T>;

  bool get isLoading => this is Loading<T>;

  bool get isInitial => this is Initial<T>;

  bool get isError => this is Failure<T>;

  bool hasError() => this is Failure;

  void when({
    Function(T? data)? initial,
    Function(T? data)? loading,
    Function(T data)? success,
    Function(DataError error)? failure,
  }) {
    switch (this) {
      case Initial _:
        final data = (this as Initial<T>).data;
        initial?.call(data);
      case Loading _:
        final data = (this as Loading<T>).data;
        loading?.call(data);
      case Success _:
        final data = this.data as T;
        success?.call(data);
      case Failure _:
        final exception = error!;
        failure?.call(exception);
    }
  }

  DataState<S> map<S>({
    DataState<S> Function(Initial<T> initial)? initial,
    DataState<S> Function(Loading<T> loading)? loading,
    required DataState<S> Function(Success<T> success) success,
    required DataState<S> Function(Failure<T> error) error,
  }) {
    switch (this) {
      case Initial _:
        return initial?.call(this as Initial<T>) ?? const Initial();
      case Loading _:
        return loading?.call(this as Loading<T>) ?? const Loading();
      case Success _:
        return success(this as Success<T>);
      case Failure _:
        return error(this as Failure<T>);
    }
  }

  Future<DataState<S>> asyncMap<S>({
    Future<DataState<S>> Function(Initial<T> initial)? initial,
    Future<DataState<S>> Function(Loading<T> loading)? loading,
    required Future<DataState<S>> Function(Success<T> success) success,
    required Future<DataState<S>> Function(Failure<T> error) error,
  }) async {
    switch (this) {
      case Initial _:
        return await initial?.call(this as Initial<T>) ?? const Initial();
      case Loading _:
        return await loading?.call(this as Loading<T>) ?? const Loading();
      case Success _:
        return await success(this as Success<T>);
      case Failure _:
        return await error(this as Failure<T>);
    }
  }

  DataState<S> mapData<S>({
    required S Function(T data) dataMapper,
  }) {
    switch (this) {
      case Success _:
        return Success(dataMapper(data as T));
      case Failure _:
        return Failure(error!);
      case Loading _:
        final data = (this as Loading<T>).data;
        return Loading(data: data == null ? null : dataMapper(data));
      case Initial _:
        final data = (this as Initial<T>).data;
        return Initial(data: data == null ? null : dataMapper(data));
    }
  }

  Future<DataState<S>> asyncMapData<S>({
    required Future<S> Function(T data) dataMapper,
  }) async {
    switch (this) {
      case Success _:
        return Success(await dataMapper(data as T));
      case Failure _:
        return Failure(error!);
      case Loading _:
        final oldData = (this as Loading<T>).data;
        return Loading(
          data: oldData == null ? null : await dataMapper(oldData),
        );
      case Initial _:
        final oldData = (this as Initial<T>).data;
        return Initial(
          data: oldData == null ? null : await dataMapper(oldData),
        );
    }
  }
}
